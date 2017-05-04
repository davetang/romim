#' Get gene/s from an OMIM ID
#'
#' Returns the gene/s associated with an OMIM entry. Entries such as 109400 are associated with more than one gene.
#' The function assumes that the gene symbol is stored in the XML node /omim/entryList/entry/phenotypeMapList/phenotypeMap/geneSymbols.
#' 
#' @param xml XML result from get_omim()
#' @keywords gene
#' @export
#' @examples
#' get_gene(get_omim(303600, geneMap=TRUE))

get_gene <- function(my_xml){
  my_gene_node <- getNodeSet(my_xml, path = "/omim/entryList/entry/phenotypeMapList/phenotypeMap/geneSymbols")
  xmlSApply(my_gene_node, xmlValue)
}

