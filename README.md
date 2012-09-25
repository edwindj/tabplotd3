tabplotd3
=========

Tabplotd3 is a R package for visualizing large datasets. It complements the 
[tabplot](http://cran.r-project.org/package=tabplot) package by providing interacte zooming, sorting and panning.

It achieves interactivity by using html and javascript served by [Rook](http://github.com/jhorner/Rook).

Usage
=====

The latest version of tabplotd3 can be installed using `devtools`.

```
install_github("edwindj", "tabplotd3")
```


Issues
======
`tabplotd3` relies on `Rook`. At the moment Rook is archived at CRAN because of conflicts with the current 
development version of `R`.  
Rook can be installed from [http://github.com/jhorner/Rook]