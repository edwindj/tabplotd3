catColumn = (plots, rb, bb, binScale) ->
	plots.each((d,i) -> 
		
		cats = d.categories
		colScale = d3.scale.ordinal()
			.domain(cats)
			.range(d.palet[0..cats.length])

		xScale = d3.scale.linear()
			.range([0,rb])

		xAxis = d3.svg.axis()
			.scale(xScale)
			.ticks(5)
			.tickFormat(d3.format("p"))

		h = 100/d.freq.length + "%"

		g = d3.select(@)
		vals = g.selectAll("g.value").data(d.freq)

		vals.enter().append("g")
			.classed("value", true)
			.attr("transform", (_,i) -> "translate(0, #{binScale(i)})")

		vals.exit().remove()

		bars = vals.selectAll("rect.freq").data((d,i) ->
			d3.zip d, offset(d)
		)


		bars.enter().append("rect")
			.classed("freq", true)
			.attr("fill", (_,i) -> colScale cats[i])
			.attr("width", (f) -> xScale(f[0]))
			.attr("x", (f) -> xScale(f[1]))
			.attr("height", h)

		g.append("g")
		  .attr("class","x axis")
		  .call(xAxis)
		  .style("display", "none")

		#TODO move this to tableplot
		g.on("mouseenter", showScale)
		.on("mouseleave", hideScale)
		return
	)

showScale = () ->
	g = d3.select(this)
	g.selectAll("g.axis").style("display", null)

hideScale = () ->
	g = d3.select(this)
	g.selectAll("g.axis").style("display", "none")