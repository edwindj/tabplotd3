.e <- new.env()

system.file <- function(..., pkg=".", package = "base", lib.loc = NULL, mustWork = FALSE){
  pkg <- as.package(pkg)
  if (package == pkg$package){
    file.path(normalizePath(pkg$path, winslash="/"), "inst", ...)
  } else {
    base::system.file(..., package=package, lib.loc=lib.loc, mustWork=mustWork)
  }
}

#' Interactive tableplot
#' 
#' \code{itabplot} is an interactive version of \code{\link{tableplot}}. It starts 
#' your browser and allows for zooming, panning and sorting the tableplot. This
#' version can be used for explorative usage, while \code{tableplot} can be used for
#' publication purposes.
#' It needs the same parameters as tabplot.
#' @param x \code{data.frame} or \code{ffdf} object used for plotting.
#' @param ... parameters that will be given to \code{tableplot}
#' @seealso \code{\link{tableplot}}
#' @export
itabplot <- function(x, ...){
  require(brew)
  require(httpuv)
  xlit <- deparse(substitute(x))
  browser()
  tp <- tableplot(x, plot=FALSE, ...)
  args <- list(...)
  
  
  #jsonf <- system.file("app/test.json", package='tabplotd3')
  # todo write in the tmp directory and move this to a seperate json function
  #writeLines(toJSON(adjust(tp)), con=jsonf)
  
#   if (is.null(.e$s)){
#     .e$s <- Rhttpd$new()
#   } else { 
#     .e$s$remove(all=TRUE)
#   }
  
#   app <- Builder$new(
#     URLMap$new( 
#       '^/json' = tpjson,
#       '^/css/' = File$new(root = system.file("app", package="tabplotd3")),
#       '^/js/'= File$new(root = system.file("app", package="tabplotd3")),
#       '^/img/'= File$new(root = "."),
#       '^*' = function(env){
#         req <- Request$new(env)
#         body <- paste(capture.output(brew(system.file("app/index.html", package="tabplotd3"))),collapse="\n")
#         res <- Response$new()
#         res$write(body)
#         res$finish()
#       }
#     )
#   )
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
                                  #, ".*" = Redirect$new("/tableplot.html")
                                  , ".*" = function(env){
                                             req <- Request$new(env)
                                             body <- paste(capture.output(brew(system.file("app/index.html", package="tabplotd3"))),collapse="\n")
                                             res <- Response$new()
                                             res$write(body)
                                             res$finish()
                                           }
                                )
                    )

  browseURL("http://localhost:8100")
  id <- runServer("0.0.0.0", 8100, list(call=app$call, onWSOpen=function(ws){}, onHeaders=function(x){}))
  #s$browse("tabplotd3")
}

#### testing
### just run this whole file after load_all()
# irisg <- iris[sample(nrow(iris), 1e4, replace=TRUE),]
#itabplot(iris)
