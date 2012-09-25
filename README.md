tabplotd3
=========

Tabplotd3 is a R package for visualizing large datasets. It complements the 
[tabplot](http://cran.r-project.org/package=tabplot) package by providing interacte zooming, sorting and panning.

It achieves interactivity by using html and javascript served by [Rook](http://github.com/jeffreyhorner/Rook).

Install
=====

Issues
------
`tabplotd3` relies on `Rook`. At the moment Rook is archived at CRAN because of conflicts with the current 
development version of `R` and therefore subsequently tabplotd3 is currently not available from CRAN.

The latest version of tabplotd3 can be installed using `devtools`.

```
# current fix for not having Rook on CRAN
install.packages("https://raw.github.com/jeffreyhorner/Rook/Rook_1.0-5.tar.gz", type="source")

install_github("edwindj", "tabplotd3")
```

Usage
=====

```
# we use the diamond data set from ggplot2, ggplot is not needed though
data(diamonds, package="ggplot2")
itabplot(diamonds)
```


