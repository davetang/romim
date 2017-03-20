#' Gene search
#'
#' This function builds the URL to search the OMIM server based on an input gene
#' 
#' @param gene_symbol Gene Symbol. Default is FGFR2.
#' @keywords Gene Symbol
#' @export
#' @examples
#' gene_to_omim(TTN)

gene_to_omim <- function(gene_symbol = 'FGFR2'){
  my_search  <- paste('http://api.omim.org/api/entry/search?search=gene_symbol:', gene_symbol, sep='')
  my_include <- 'include=geneMap'
  my_query   <- paste(my_search, my_include, my_key, sep = "&")
  my_result  <- xmlParse(my_query)
  my_list    <- xmlToList(my_result)
  my_xml     <- my_list$searchResponse$entryList$entry$geneMap$phenotypeMapList
  as.vector(unlist(sapply(my_xml, function(x) x$phenotypeMimNumber)))
}
 
