tabplotd3
=========

Tabplotd3 is a R package for visualizing large datasets. It complements the 
[tabplot](http://cran.r-project.org/package=tabplot) package by providing interactive zooming, sorting and panning.

It achieves interactivity by using html and javascript served by [Rook](http://github.com/jeffreyhorner/Rook).

Install
=====

The latest version of tabplotd3 can be installed using `devtools`.

```
install_github("edwindj", "tabplotd3")
```

Usage
=====

```
# we use the diamond data set from ggplot2, ggplot is not needed though
data(diamonds, package="ggplot2")
itabplot(diamonds)
```


