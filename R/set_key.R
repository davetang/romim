#' Set API key
#'
#' This function sets the API key
#' 
#' @param key Your API key
#' @keywords key
#' @export
#' @examples
#' set_key('aAS5ASdf35jasdnadsfj') # not a real key

set_key <- function(key){
  my_key <<- paste('apiKey=', key, sep='')
}
 
