function offSet(d){
   var cs = [0];
   for (var i = 1; i < d.length; i++){
      cs[i] = cs[i-1] + d[i-1];
   }
   return cs;
}

function sortVar(d,i){
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
}

function redraw(){
   zoomUpdate();
   var params = d3.entries(tp.settings).map(function(d) d.key + "=" + d.value);   
   d3.json("json?" + params.join("&"), draw)
}