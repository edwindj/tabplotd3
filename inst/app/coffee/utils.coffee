move = () ->
	console.log d3.event.scale
	svg = d3.selectAll("g.plot")
	.transition()
	  .attr("transform", "translate(0, #{d3.event.translate[1]}) scale(1,#{d3.event.scale})")
	.each("end",(_, i)->
		return if i
		d = yScale.domain()
		tp.settings.from = d[0]*100
		tp.settings.to = d[1]*100
		redraw()
		)

redraw = ->
	params = ("#{key}=#{value}" for key, value of tp.settings)
	d3.select("table.tableplot").style("cursor", "wait")
	d3.json "json?" +  params.join("&"), draw
	return

sortVar = (e) ->
	if tp.settings.sortCol is e then tp.settings.decreasing = not tp.settings.decreasing
	tp.settings.sortCol = e
	tp.settings.from = 0
	tp.settings.to = 100
	redraw()

zoom = () ->
   if d3.event.scale? and d3.event.scale is 1 then return
   d = yScale.domain()
   tp.settings.from = d[0]*100;
   tp.settings.to = d[1]*100;
   redraw()
