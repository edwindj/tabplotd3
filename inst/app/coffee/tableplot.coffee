###
###

@tp ?= {}

@tp.settings ?= {}

tp.tableplot = () ->
	margin = top: 0, bottom: 0,	left: 60, right: 0

	width = 800
	height = 600
	
	x = d3.scale.linear()
	      .domain([0,1])
	y = d3.scale.ordinal()
	colScale = d3.scale.linear()
	           .domain([0, 1])
	           .range(["white", "steelblue"])

	tableplot = {}

	tableplot.width = (w) ->
		if w?
			width = w
			tableplot
		else
			width

	tableplot.height = (h) ->
		if h?
			height = h
			tableplot
		else
			height

	tableplot.draw = (data) ->
		w = width - (margin.left +  margin.right)
		h = height - (margin.top + margin.bottom)

		x = x.range([0, w])
		y = y.domain(d3.range(data.nBins))
		     .rangeBands([0, h])

		vars = d3.keys data.vars
		vis = d3.select("#vis")
		
		cols = vis.selectAll("g.column").data(data)

		cols.enter().append("g")
		   .classed("column", true)
		   .attr("transform", (d,i) -> "translate(#{y(i)})")
		   .append("rect")
		   
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

@draw = (data) ->
	tp.tableplot().draw(data)