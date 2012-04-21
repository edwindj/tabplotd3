s <- NULL

#' itabplot
#' @export
itabplot <- function(x, ...){
  tp <- tableplot(x, plot=FALSE)
  # todo write in the tmp directory and move this to a seperate json function
  writeLines(toJSON(adjust(tp)), con=system.file('app/test.json', package='tabplotd3'))
  if (is.null(s)){
    s <<- Rhttpd$new()
  }
  
  s$launch( app=system.file('app/config.R', package='tabplotd3')
          ,  name='tabplotd3'
          , ...
          ) 
}

render_json <- function(x){
   RJSONIO::toJSON(x)
}

#### testing

itabplot(iris)