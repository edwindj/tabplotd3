
# adjustment of tableplot object, to be implemented in tabplot itself
adjust <- function(tp){
  atp <- list()
  varnms <- sapply(tp$columns, function(i) i$name)
  vars <- lapply( tp$columns
                  , function(i) { if (i$isnumeric)
                    return(list( mean = i$mean
                                 , compl = i$compl/100
                                 )
                           )
                          categories <- colnames(i$freq)
                          freq <- round(i$freq / rowSums(i$freq), 4)
                          colnames(freq) <- NULL
                          list( freq = freq, palet=i$palet, categories=categories)
                                  
                  }
                  )
  names(vars) <- varnms
  atp$vars <- vars
  atp
}
