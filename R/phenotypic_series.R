#' OMIM Phenotypic Series
#'
#' This function returns OMIM IDs given a OMIM Phenotypic Series ID.
#' Recursive apply (rapply) and grep is used because phenotypeMimNumber is not always present in the same XML structure.
#' 
#' @param series Phenotypic Series Number. Default is PS163950.
#' @keywords Phenotypic Series Number
#' @export
#' @examples
#' phenotypic_series(series = 'PS308350')

phenotypic_series <- function(series = 'PS163950'){
  my_search  <- paste('http://api.omim.org/api/entry/search?search=phenotypic_series_number:', series, sep='')
  my_include <- 'include=geneMap'
  start      <- 0
  limit      <- 20 # max limit is 20 when geneMap is included
  my_start   <- paste('start=', start, sep='')
  my_limit   <- paste('limit=', limit, sep='')
  my_query   <- paste(my_search, my_include, my_key, my_start, my_limit, sep = "&")
  my_result  <- xmlParse(my_query)
  my_list    <- xmlToList(my_result)
  my_total   <- as.numeric(my_list$searchResponse$totalResults)
  tmp        <- rapply(my_list, function(x) x)
  my_omim    <- as.vector(tmp[grep('phenotypeMimNumber', names(tmp))])

  if (my_total < 21){
    return(unique(my_omim))
  } else {
    my_last <- round(my_total/20)
    for(i in 2:my_last){
      start     <- start + 20
      my_start  <- paste('start=', start, sep='')
      my_query  <- paste(my_search, my_include, my_key, my_start, my_limit, sep = "&")
      my_result <- xmlParse(my_query)
      my_list   <- xmlToList(my_result)
      my_total  <- as.numeric(my_list$searchResponse$totalResults)
      tmp       <- rapply(my_list, function(x) x)
      my_omim   <- c(my_omim, as.vector(tmp[grep('phenotypeMimNumber', names(tmp))]))
    }
    return(unique(my_omim))
  }
}

