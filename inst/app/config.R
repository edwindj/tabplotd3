app <- Builder$new( Static$new( urls = c('/css','/img','/js')
                              , root = '.'
                              )
                  , URLMap$new( '/json' = function(env){
                                }
                              , '.' = Redirect$new('index.html')                        
                              )
                  )
