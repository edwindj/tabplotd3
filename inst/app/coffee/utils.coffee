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
   d = yScale.domain()
   tp.settings.from = d[0]*100;
   tp.settings.to = d[1]*100;
   redraw()
