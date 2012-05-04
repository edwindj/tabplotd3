tpjson <- function(env){
  req <- Request$new(env)
  res <- Response$new()
  res$header('Content-type','application/json')
  
  params <- req$params()
  print(params)
  
  if ("dat" %in% names(params)){
    params[["dat"]] <- eval(as.name(params[["dat"]]), envir=.GlobalEnv)
    nums <- match(c("from", "to"), names(params), nomatch=0)
    #print(list(nums=nums, params=params))
    params[nums] <- lapply(params[nums], as.numeric)
    params["decreasing"] <- !params["decreasing"] %in% c("false")
    #print(params)
    tp <- do.call(tableplot, params)
    res$write(toJSON(adjust(tp)))
  }
  else {
    dmp <- list(params=params)
    res$write(toJSON(dmp))
  }
  res$finish();
}