#' Get phenotype mapping key for an OMIM gene
#'
#' This function parses the XML result and extracts the phenotype mapping key for the gene associated with an OMIM ID
#' 
#' @param xml XML result from get_omim()
#' @keywords phenotype mapping key
#' @export
#' @examples
#' get_pheno_key(get_omim(303600, geneMap=TRUE))

get_pheno_key <- function(xml){
  xml_list <- xmlToList(xml)
  return(xml_list$entryList$entry$phenotypeMapList$phenotypeMap$phenotypeMappingKey)
}

