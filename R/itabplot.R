s <- NULL

#' itabplot
#' @export
itabplot <- function(x, ...){
  tp <- tableplot(x, plot=FALSE)
  #toJSON(tp)
  if (is.null(s)){
    s <- Rhttpd$new()
    s$launch( name='tabplotd3'
            , app=system.file('app/config.R', package='tabplotd3')
            , ...
            )
  } 
}

render_json <- function(x){
   RJSONIO::toJSON(x)
}