s <- NULL

#' itabplot
#' @export
itabplot <- function(...){
  if (is.null(s)){
    s <- Rhttpd$new()
    s$launch( name='tabplotd3'
            , app=system.file('app/config.R', package='tabplotd3')
            , ...
            )
  }
  
  
}