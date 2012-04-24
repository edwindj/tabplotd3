tpjson <- function(env){
  req <- Request$new(env)
  res <- Response$new()
  res$header('Content-type','application/json')
  
  params <- req$params()
  print(params)
  
  if ("dat" %in% names(params)){
    params[["dat"]] <- eval(as.name(params[["dat"]]), envir=.GlobalEnv)
    tp <- do.call(tableplot, params)
    res$write(toJSON(adjust(tp)))
  }
  else {
    dmp <- list(params=params)
    res$write(toJSON(dmp))
  }
  res$finish();
}