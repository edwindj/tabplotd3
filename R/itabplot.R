.app <- NULL

#' itabplot
#' @param data data
#' @export
itabplot <- function(data){
  if (is.null(.app)){
    .app <- RhttpdApp
  }
}