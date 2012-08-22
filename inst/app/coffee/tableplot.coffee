###
###

tp = @tp ?= {}
settings = tp.settings ?= {}

@data;

settings.sortCol ?= 0
settings.from ?= 0
settings.to ?= 100

yScale = null
yAxis = null
yZoom = null

@draw = (data) ->
	width = $("#plot").width()
	console.log $(document).height(), $(window).height()
	#width = 1024
	height = $(document).height() - 150
	margin = top: 0, bottom: 0,	left: 60, right: 20

	vars = d3.keys data.vars
	values = d3.values data.vars

	clmScale = d3.scale.ordinal()
		.domain(vars)
		.rangeBands([margin.left,width - margin.right])
	rb = clmScale.rangeBand()

	binScale = d3.scale.linear()
	   .domain([0, data.nBins])
	   .range([10,height-20])

	yScale = d3.scale.linear()
		.domain([settings.from/100, settings.to/100])
		.range([10,height-20])
		.clamp(true)


	bb = height / data.nBins

	colScale = d3.scale.linear()
	   .range(["white", "steelblue"])

    d3.select("table.tableplot").remove()
	vis = d3.select("#plot").append("table").classed("tableplot", true)
	header = vis.append("tr").classed("header", true)
	column = vis.append("tr").classed("column", true)

	headers = header.selectAll("td").data(vars)
	header.append("td")
	
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
	column.append("td")
	  .append("svg")
	  .attr("width", 50)
	  .attr("height", height)
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

	yZoom = d3.behavior.zoom()
		.y(yScale)
		.scaleExtent([0,data.nBins])
		.on("zoom", move)

	plots.call(yZoom)

	yAxis = addAxis()

@offset = (a) ->
	cs = [0]
	for i in [1..a.length]
		cs[i] = cs[i-1] + a[i-1]
	cs