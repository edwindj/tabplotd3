s <- NULL

#' itabplot
#' @export
itabplot <- function(x, ...){
  tp <- tableplot(x, plot=FALSE, ...)
  jsonf <- system.file("app/test.json", package='tabplotd3')
  # todo write in the tmp directory and move this to a seperate json function
  writeLines(toJSON(adjust(tp)), con=jsonf)
  
  if (is.null(s)){
    s <<- Rhttpd$new()
  }
  
  apps <- system.file('app/config.R', package='tabplotd3')
  print(apps)
  s$launch( app=apps
          , name='tabplotd3'
          ) 
}

#### testing
#  itabplot(iris)