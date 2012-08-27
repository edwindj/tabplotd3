move = () ->
	svg = d3.selectAll("g.plot")
	axis = d3.selectAll(".y.axis")
	
	fromto = yScale.domain()
	#fromto = [d3.max([fromto[0], 0]), d3.min([fromto[1], 1])]
	#yScale.domain(fromto)

	#console.log fromto, d3.event.translate, yZoom.translate()
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
		zoomUpdate(yScale.domain().map((d) -> 100*d))
		redraw()
		)

@redraw = ->
	zoomUpdate()
	params = ("#{key}=#{value}" for key, value of tp.settings)
	d3.selectAll("svg").style "cursor", "progress"
	d3.json "json?" +  params.join("&"), draw
	return

sortVar = (e) ->
	if tp.settings.sortCol is e then tp.settings.decreasing = not tp.settings.decreasing
	tp.settings.sortCol = e
	tp.settings.from = 0
	tp.settings.to = 100
	redraw()

@params = ((qs) ->
	qs = qs.substr(1).split("&")
	params = {}
	sqs = (p.split('=') for p in qs)
	params[p[0]] = decodeURIComponent p[1] for p in sqs
	params
)(window.location.search)

@zoomUpdate = (fromto) ->
   if fromto?
   		[tp.settings.from,tp.settings.to] = fromto
   [from,to]  = [tp.settings.from, tp.settings.to]
   from = tp.settings.from;
   to = tp.settings.to;
   $( "#from" ).val(from);
   $( "#to" ).val(to);
   $("#from_to").slider("option", "values", [from,to]);

showScale = () ->
	g = d3.select(this)
	g.selectAll("g.ruler").style("display", null)

hideScale = () ->
	g = d3.select(this)
	g.selectAll("g.ruler").style("display", "none")

highlight = (d,i) ->
	g = d3.select(this)
