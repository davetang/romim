#' Get gene/s from an OMIM ID
#'
#' This function parses the XML result and extracts the genes associated with an OMIM ID
#' 
#' @param xml XML result from get_omim()
#' @keywords gene
#' @export
#' @examples
#' get_gene(get_omim(303600, geneMap=TRUE))

get_gene <- function(xml){
  xml_list <- xmlToList(xml)
  return(xml_list$entryList$entry$phenotypeMapList$phenotypeMap$geneSymbols)
}

