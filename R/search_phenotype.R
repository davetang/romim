#' Search OMIM
#'
#' This function returns OMIM phenotypes given a match of a search term in the text meta field of OMIM phenotype entries.
#' Recursive apply (rapply) and grep is used because phenotypeMimNumber is not always present in the same XML structure.
#' 
#' @param series Search term. Default is "noonan syndrome".
#' @param show_query Show API query. Default is FALSE.
#' @keywords Search OMIM
#' @export
#' @examples
#' search_phenotype(search_term = 'noonan syndrome')

search_phenotype <- function(search_term = 'noonan syndrome', show_query = FALSE){
  search_term <- gsub("\\s", '%20', search_term)
  search_term <- sub("^", "%22", search_term)
  search_term <- sub("$", "%22", search_term)
  # my_search   <- paste('https://api.omim.org/api/entry/search?search=', search_term, '+AND+gm_phenotype_exists:true', sep='')
  my_search   <- paste('https://api.omim.org/api/entry/search?search=', search_term, sep='')
  my_include  <- 'include=geneMap'
  start       <- 0
  limit       <- 20 # max limit is 20 when geneMap is included
  my_start    <- paste('start=', start, sep='')
  my_limit    <- paste('limit=', limit, sep='')
  my_query    <- paste(my_search, my_include, my_key, my_start, my_limit, sep = "&")
  if (show_query){
     message(my_query)
  }
  my_result   <- read_xml(my_query) %>% xmlParse(.)
  my_list     <- xmlToList(my_result)
  my_total    <- as.numeric(my_list$searchResponse$totalResults)
  tmp         <- rapply(my_list, function(x) x)
  my_omim     <- as.vector(tmp[grep('phenotypeMimNumber', names(tmp))])

  if (my_total < 21){
    return(unique(my_omim))
  } else {
    if (my_total > 100){
       return(paste('Please use more specific term/s; search term: ', search_term, ' returned over 100 results (', my_total, ')', sep = ''))
    }
    my_last <- round(my_total/20)
    for(i in 2:my_last){
      start     <- start + 20
      my_start  <- paste('start=', start, sep='')
      my_query  <- paste(my_search, my_include, my_key, my_start, my_limit, sep = "&")
      my_result <- read_xml(my_query) %>% xmlParse(.)
      my_list   <- xmlToList(my_result)
      my_total  <- as.numeric(my_list$searchResponse$totalResults)
      tmp       <- rapply(my_list, function(x) x)
      my_omim   <- c(my_omim, as.vector(tmp[grep('phenotypeMimNumber', names(tmp))]))
    }
    return(unique(my_omim))
  }
}

