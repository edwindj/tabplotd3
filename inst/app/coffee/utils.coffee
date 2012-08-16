move = () ->
	svg = d3.selectAll("g.plot")
	axis = d3.selectAll(".y.axis")
	
	fromto = yScale.domain()
	fromto = [d3.max([fromto[0], 0]), d3.min([fromto[1], 1])]
	yScale.domain(fromto)

	console.log fromto, d3.event.translate, yZoom.translate()
	if d3.event.scale is 1
		svg.attr("transform", "translate(0, #{d3.event.translate[1]})")
		axis.call(yAxis)
	
	svg = svg.transition()
	axis = axis.transition()
	axis.call(yAxis)

	svg.attr("transform", "translate(0, #{d3.event.translate[1]}) scale(1,#{d3.event.scale})")
	.each("end",(_, i)->
		return if i
		d = yScale.domain()
		tp.settings.from = d3.max([d[0]*100, 0])
		tp.settings.to = d3.min([d[1]*100, 100])
		d3.selectAll("svg").style "cursor", "progress"
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
   tp.settings.from = d3.max(d[0]*100, 0);
   tp.settings.to = d3.min(d[1]*100, 100);
   redraw()

@params = ((qs) ->
	qs = qs.substr(1).split("&")
	params = {}
	sqs = (p.split('=') for p in qs)
	params[p[0]] = decodeURIComponent p[1] for p in sqs
	params
)(window.location.search)