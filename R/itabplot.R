s <- NULL

#' itabplot
#' @export
itabplot <- function(x, ...){
  xlit <- deparse(substitute(x))
  tp <- tableplot(x, plot=FALSE, ...)
  
  jsonf <- system.file("app/test.json", package='tabplotd3')
  # todo write in the tmp directory and move this to a seperate json function
  writeLines(toJSON(adjust(tp)), con=jsonf)
  
  if (is.null(s)){
    s <<- Rhttpd$new()
    apps <- system.file('app/config.R', package='tabplotd3')
    s$launch( app=apps
            , name='tabplotd3'
            ) 
  }
  s$browse("tabplotd3")
}

#### testing
irisg <- iris[sample(nrow(iris), 1e5, replace=TRUE),]
itabplot(irisg)