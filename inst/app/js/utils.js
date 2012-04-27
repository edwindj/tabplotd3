function offSet(d){
   var cs = [0];
   for (var i = 1; i < d.length; i++){
      cs[i] = cs[i-1] + d[i-1];
   }
   return cs;
}

function sortVar(d,i){
   tp.settings.sortCol = d;
   var params = d3.entries(tp.settings).map(function(d) d.key + "=" + d.value);
   
   d3.json("json?" + params.join("&"), draw)
}

function highlightText(selection){
   selection
      .on("mouseover", function() {d3.select(this).classed("highlight", true)})
	  .on("mouseout", function() {d3.select(this).classed("highlight", false)})
	  ;
}