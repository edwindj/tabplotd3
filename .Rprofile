system.file <- function(..., pkg=NULL, package = "base", lib.loc = NULL, mustWork = FALSE){
 pkg <- as.package(pkg)
 if (package == pkg$package){
   file.path(normalizePath(pkg$path, winslash="/"), "inst", ...)
 } else {
   base::system.file(..., package=package, lib.loc=lib.loc, mustWork=mustWork)
 }
}

.First <- function(){
  
  if (require(devtools)){
    as.package(".")
  }
}
