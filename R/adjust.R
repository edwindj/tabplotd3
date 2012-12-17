#' adjustment of tableplot object, to be implemented in tabplot itself
#' @keywords internal 
adjust <- function(tp){
  atp <- list()
  #browser()
  varnms <- sapply(tp$columns, function(i) i$name)
  vars <- lapply( tp$columns
                  , function(i) { if (i$isnumeric)
                    return(list( mean = i$mean
                                 , compl = i$compl/100
                                 )
                           )
                          categories <- i$categories
                          freq <- round(i$freq, 4)
                          #freq <- round(i$freq / rowSums(i$freq), 4)
                          print(i)
                          colnames(freq) <- NULL
                          list( freq = freq, palet=i$palet, categories=categories)
                                  
                  }
                  )
  names(vars) <- varnms
  atp$vars <- vars
#   atp$dataset <- tp$dataset
  atp$sortCol <- unlist(lapply(tp$columns, function(x) if (!is.na(x$sort_decreasing)) x$name))
  atp$nBins <- tp$nBins
  atp
}