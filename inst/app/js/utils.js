function offSet(d){
   var cs = [0];
   for (var i = 1; i < d.length; i++){
      cs[i] = cs[i-1] + d[i-1];
   }
   return cs;
}

function sortVar(d,i){
   tp.settings.decreasing = !(tp.settings.decreasing || tp.settings.sortCol != d);
   tp.settings.sortCol = d;
   tp.settings.from = 0;
   tp.settings.to = 100;
   redraw();
}

function highlightText(selection){
   selection
     .on("mouseover", function() {d3.select(this).classed("highlight", true)})
	  .on("mouseout", function() {d3.select(this).classed("highlight", false)})
	  ;
}

function zoomUpdate(){
   var from = tp.settings.from;
   var to = tp.settings.to;
   $( "#from" ).val(from);
   $( "#to" ).val(to);
   $("#from_to").slider("option", "values", [from,to]);
   yAxis.scale().domain([from/100, to/100]);
}

function zoom(){
   var d = yAxis.scale().domain();
   tp.settings.from = d[0]*100;
   tp.settings.to = d[1]*100;
   redraw();
}

function redraw(){
   zoomUpdate();
   var params = d3.entries(tp.settings).map(function(d) {return d.key + "=" + d.value});   
   d3.json("json?" + params.join("&"), draw)
   d3.select(".y.axis").transition().duration(500).call(yAxis);
}