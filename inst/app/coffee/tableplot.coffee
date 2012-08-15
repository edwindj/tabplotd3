###
###

tp = @tp ?= {}
settings = tp.settings ?= {}

@data;

settings.sortCol ?= 0
settings.from ?= 0
settings.to ?= 100

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

	tableplot = (data) ->
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

	return tableplot

yScale = null

@draw = (data) ->
	width = 1024
	height = 600
	margin = top: 0, bottom: 0,	left: 60, right: 0

	vars = d3.keys data.vars
	values = d3.values data.vars

	clmScale = d3.scale.ordinal()
		.domain(vars)
		.rangeBands([0,width])
	rb = clmScale.rangeBand()

	binScale = d3.scale.linear()
	   .domain([0, data.nBins])
	   .range([0,height])

	yScale = d3.scale.linear()
		.domain([settings.from/100, settings.to/100])
		.range([0,height])


	bb = height / data.nBins

	colScale = d3.scale.linear()
	   .range(["white", "steelblue"])

    d3.select("table.tableplot").remove()
	vis = d3.select("#plot").append("table").classed("tableplot", true)
	header = vis.append("tr").classed("header", true)
	column = vis.append("tr").classed("column", true)

	headers = header.selectAll("td").data(vars)
	
	headers.enter()
		.append("td")
		.append("button")
		.style("width", "100%")
		.style("height", "3em")
		.on("click", sortVar)
		.text((d) -> d)
		.each((d) ->
			option = {icons:{secondary: "ui-icon-triangle-2-n-s"}}
			if d is settings.sortCol
				option.icons.secondary = if settings.decreasing then "ui-icon-triangle-1-s" else "ui-icon-triangle-1-n" 
			$(this).button(option)
		)
	headers.exit().remove()

	columns = column.selectAll("td").data(vars)

	columns.enter()
	.append("td")
	.append("svg")
	  .attr("width",  rb)
	  .attr("height", height)
	  .style("cursor", "all-scroll")
	.each(() -> 
		d3.select(this)
	   	.append("rect")
	   		.attr("width","100%")
	   		.attr("height", "100%")
	   		.classed("panel", true)
	)
	.append("g")
		.classed("plot", true)
		.datum((d,i) -> values[i])   

	plots = columns.selectAll("g.plot")

	plots.filter((d) -> d.mean?)
		.call(numColumn, rb, bb, binScale, colScale)
	
	plots.filter((d) -> not d.mean?)
		.call(catColumn, rb, bb, binScale)

	plots.call( d3.behavior.zoom()
		        .y(yScale)
		        .scaleExtent([0,data.nBins])
		        .on("zoom", move))

@offset = (a) ->
	cs = [0]
	for i in [1..a.length]
		cs[i] = cs[i-1] + a[i-1]
	cs