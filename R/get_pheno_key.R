#' Get phenotype mapping key for gene/s associated with an OMIM entry
#'
#' Returns the phenotype mapping key of gene/s associated with an OMIM entry.
#' Assumes that the phenotype mapping key is stored in the XML node /omim/entryList/entry/phenotypeMapList/phenotypeMap/phenotypeMappingKey.
#'
#' @param xml XML result from get_omim()
#' @keywords phenotype mapping key
#' @export
#' @examples
#' get_pheno_key(get_omim(303600, geneMap=TRUE))

get_pheno_key <- function(xml){
  my_pheno_node <- getNodeSet(my_xml, path = "/omim/entryList/entry/phenotypeMapList/phenotypeMap/phenotypeMappingKey")
  xmlSApply(my_pheno_node, xmlValue)
}

