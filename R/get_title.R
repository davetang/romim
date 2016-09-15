#' Get title from an OMIM ID
#'
#' This function parses the XML result and extracts the title of an OMIM ID
#' 
#' @param xml XML result from get_omim()
#' @keywords title
#' @export
#' @examples
#' get_title(get_omim(100200))

get_title <- function(xml){
  xml_list <- xmlToList(xml)
  return(xml_list$entryList$entry$titles$preferredTitle)
}

