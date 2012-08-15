numColumn = (plots, rb, bb, binScale, colScale) ->
	plots.each( (d,i) ->
		xScale = d3.scale.linear()
			.domain(d3.extent(d.mean.concat(0)))
			.range([0,rb])

		zero = xScale 0

		g = d3.select(this)
		vals = g.selectAll("g.value").data(d.mean)

		vals.enter().append("g")
			.classed("value", true)
			.append("rect")
			.attr("title", (d,i) -> "value = #{d}")
			.attr("width", (d) -> xScale(d) - zero)
			.attr("x", zero)
			.attr("height", bb)
			.attr("y", (_,i) -> binScale(i))
			.attr("fill", (_,i) -> colScale(d.compl[i]))		
		return
	)