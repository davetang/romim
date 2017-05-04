#' Get inheritance model of genes associated with OMIM ID
#'
#' Returns the inheritance model of a gene/s associated with the OMIM entry.
#' An OMIM entry may be associated to more than one gene and therefore will have more than one inheritance model.
#' The function assumes that the inheritance model is stored in the XML node /omim/entryList/entry/phenotypeMapList/phenotypeMap/phenotypeInheritance.
#' The clinical synopsis contains the inheritance model of the OMIM entry.
#'
#' @param xml XML result from get_omim()
#' @keywords inheritance
#' @export
#' @examples
#' get_inheritance(get_omim(303600, geneMap=TRUE))

get_inheritance <- function(xml){
  my_inheritance_node <- getNodeSet(my_xml, path = "/omim/entryList/entry/phenotypeMapList/phenotypeMap/phenotypeInheritance")
  xmlSApply(my_inheritance_node, xmlValue)
}

