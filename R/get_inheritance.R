#' Get inheritance model from an OMIM ID
#'
#' This function parses the XML result and extracts the inheritance model associated with an OMIM ID
#' 
#' @param xml XML result from get_omim()
#' @keywords inheritance
#' @export
#' @examples
#' get_inheritance(get_omim(303600, geneMap=TRUE, clinicalSynopsis=TRUE))

get_inheritance <- function(xml){
  xml_list <- xmlToList(xml)
  return(xml_list$entryList$entry$clinicalSynopsis$inheritance)
}

