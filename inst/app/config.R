app <- Builder$new( Static$new( urls = c('/css/','/img/','/js/','/.+\\.json$') #, "/.*\\.html$")
                              , root = system.file("app", package="tabplotd3")#"."
                              )
                  , Brewery$new(url='.*\\.html$',root= system.file("app", package="tabplotd3"))
                  , URLMap$new( '^/json' = tpjson
                              , ".*" = Redirect$new("/bar.html")
                              )
                  )

#s$launch(app, "app")
