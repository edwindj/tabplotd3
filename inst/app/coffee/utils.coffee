move = () ->
	console.log d3.event.scale, d3.event.translate
	svg = d3.selectAll("g.plot")
	.transition()
	  .attr("transform", "translate(0, #{d3.event.translate[1]}) scale(1,#{d3.event.scale})")
	.each("end",(_, i)->
		return if i
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
	g.selectAll("g.axis").style("display", null)

hideScale = () ->
	g = d3.select(this)
	g.selectAll("g.axis").style("display", "none")