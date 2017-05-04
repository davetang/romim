#' Get title from an OMIM ID
#'
#' Returns the preferred title of an OMIM entry.
#' The function assumes that the preferred title is in the XML node /omim/entryList/entry/titles/preferredTitle.
#'
#' @param xml XML result from get_omim()
#' @keywords title
#' @export
#' @examples
#' get_title(get_omim(100200))

get_title <- function(my_xml){
  my_preferred_title_node <- getNodeSet(my_xml, path = "/omim/entryList/entry/titles/preferredTitle")
  xmlSApply(my_preferred_title_node, xmlValue)
}

