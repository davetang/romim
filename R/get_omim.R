#' Query OMIM server
#'
#' This function builds the URL and queries the OMIM server
#' 
#' @param omim_id OMIM ID. Default is 100100.
#' @param text Includes the text field sections with the entry. Default is FALSE.
#' @param existflags Include the 'exists' flags with the entry (clinical synopsis, allelic variant, gene map & phenotype map). Default is FALSE.
#' @param allelicVariantList Includes the allelic variant list with the entry. Default is FALSE.
#' @param clinicalSynopsis Include the clinical synopsis with the entry. Default is FALSE.
#' @param seeAlso Includes the 'see also' field with the entry. Default is FALSE.
#' @param referenceList Include the reference list with the entry. Default is FALSE.
#' @param geneMap Include the gene map/phenotype map data with the entry. Default is FALSE.
#' @param externalLinks Include the external links with the entry. Default is FALSE.
#' @param contributors Includes the 'contributors' field with the entry. Default is FALSE.
#' @param creationDate Includes the 'creation date' field with the entry. Default is FALSE.
#' @param editHistory Includes the 'edit history' field with the entry. Default is FALSE.
#' @param dates Include the dates data with the entry. Default is FALSE.
#' @param all the above data with the entry. Default is FALSE.
#' @keywords OMIM ID
#' @export
#' @examples
#' get_omim(303600, geneMap = TRUE)

get_omim <- function(omim_id = 100100, #default OMIM ID
  text = FALSE, #Includes the text field sections with the entry.
  existflags = FALSE, #Include the 'exists' flags with the entry (clinical synopsis, allelic variant, gene map & phenotype map).
  allelicVariantList = FALSE, #Includes the allelic variant list with the entry.
  clinicalSynopsis = FALSE, #Include the clinical synopsis with the entry.
  seeAlso = FALSE, #Includes the 'see also' field with the entry.
  referenceList = FALSE, #Include the reference list with the entry.
  geneMap = FALSE, #Include the gene map/phenotype map data with the entry.
  externalLinks = FALSE, #Include the external links with the entry.
  contributors = FALSE, #Includes the 'contributors' field with the entry.
  creationDate = FALSE, #Includes the 'creation date' field with the entry.
  editHistory = FALSE, #Includes the 'edit history' field with the entry.
  dates = FALSE, #Include the dates data with the entry.
  all = FALSE #Include the above data with the entry.
){
  #get all the arguments of the function call
  a <- as.list(match.call())
  my_mim   <- paste('mimNumber=', omim_id, sep='')
  my_link  <- 'http://api.omim.org/api/entry?'
  my_query <- paste(my_link, my_mim, my_key, sep = "&")
  #loop through all the arguments
  for (i in names(a)){
    #skip the omid_id and blank argument
    if(!i %in% '' && !i %in% 'omim_id'){
      my_include <- paste('&', 'include=', i, sep='')
      my_query <- paste(my_query, my_include, sep='')
    }
  }
  xmlParse(my_query)
}
 
