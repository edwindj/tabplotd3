###
Comments
###

@tp ?= {}

tp.tableplot = () ->
	margin = top: 0, bottom: 0,	left: 60, right: 0

	width = 800
	height = 600
	
	x = d3.scale.linear()
	      .domain([0,1])
	y = d3.scale.ordinal()
	z = d3.scale.linear()
	      .domain([0, 1])
	      .range(["white", "steelblue"])

	tableplot = (selection) ->
		selection.each (d,i) ->

	tableplot.width = (w) ->
		if arguments.length
			width = w
			tableplot
		else
			width

	tableplot.height = (h) ->
		if arguments.length
			height = h
			tableplot
		else
			height


	draw = (data) ->
		w = width - (margin.left +  margin.right)
		h = height - (margin.top + margin.bottom)

		x = x.range([0, w])
		y = y.domain(d3.range(data.nBins))
		     .rangeBands([0, h])

		vars = d3.keys data.vars
		vis = d3.select this

		cols = vis.selectAll("g.columns").data(vars)

		types = for k, v of data.vars
		  if v.mean? then "numeric" else "categorical"

		cols.enter().append("g")
		   .classed("column", true)
		   .classed("numeric", (d) -> data.vars[d].mean?)
		   .classed("categorical", (d) -> data.vars[d].categories?)

		cols.exit().remove()

		for k, v of data.vars
		  if v.mean?
		    numColumn v
		  else
		    catColumn v
		return
	return tableplot

numColumn = (data, xScale, yScale) ->
catColumn = (data, xScale, yScale) -> 