app <- Builder$new( Static$new( urls = c('/css','/img','/js')
                              , root = system.file("app", package="tabplotd3")
                              )
                  , URLMap$new( '^/json' = function(env){
                                }
                              , "^/.*" = function(env){
                                   req <- Request$new(env)
                                   res <- Response$new()
                                   res$redirect(req$to_url("/index.html"))
                                   res$finish()
                                }
                              )
                  )

s$launch(app, "app")