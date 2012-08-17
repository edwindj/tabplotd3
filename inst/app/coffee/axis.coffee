addAxis = (yAxis) ->
	yAxis = d3.svg.axis()
	  .scale(yScale)
	  .orient("left")
	  .ticks(5)
	  .tickFormat(d3.format(".3p"))

	svg = d3.select "svg"
	svg.append("g")
	  .attr("class", "y axis")
	  .attr("transform", "translate(50,0)")
	  .call(yAxis)
	yAxis