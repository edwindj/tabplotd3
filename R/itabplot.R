s <- NULL


system.file <- function(..., pkg=NULL, package = "base", lib.loc = NULL, mustWork = FALSE){
  pkg <- as.package(pkg)
  if (package == pkg$package){
    file.path(normalizePath(pkg$path, winslash="/"), "inst", ...)
  } else {
    base::system.file(..., package=package, lib.loc=lib.loc, mustWork=mustWork)
  }
}

#' itabplot
#' @export
itabplot <- function(x, ...){
  xlit <- deparse(substitute(x))
  tp <- tableplot(x, plot=FALSE, ...)
  args <- list(...)
  
  #jsonf <- system.file("app/test.json", package='tabplotd3')
  # todo write in the tmp directory and move this to a seperate json function
  #writeLines(toJSON(adjust(tp)), con=jsonf)
  
  if (is.null(s)){
    s <<- Rhttpd$new()
  } else { 
    s$remove(all=TRUE)
  }
  
  app <- Builder$new( Static$new( urls = c('/css/','/img/','/js/','/.+\\.json$') #, "/.*\\.html$")
                                , root = system.file("app", package="tabplotd3")#"."
                                )
                    , Brewery$new( url='.*\\.html$'
                                 , root= system.file("app", package="tabplotd3")
                                 , dat=x
                                 , xlit=xlit
                                 , args=args
                                 , ...
                                 )
                    , URLMap$new( '^/json' = tpjson
                                , ".*" = Redirect$new("/tableplot.html")
                                )
                    )
  s$launch( app=app
          , name='tabplotd3'
          ) 
  #s$browse("tabplotd3")
}

#### testing
### just run this whole file after load_all()
# irisg <- iris[sample(nrow(iris), 1e4, replace=TRUE),]
# itabplot(irisg)