function catvar(data, container, offset, width, height, sc_bin){
   freq = data.freq;
   
   sc_x = d3.scale.linear()
       .domain([0, 1])
       .range([0, width]);
       
   pal = d3.scale.ordinal().range(data.palet);

   var palette = data.palet;
   
   var vis = container.append("svg:g")
       .attr("class", "catvar")
       .attr("transform", "translate("+offset+")");

   vis.append("svg:rect")
      .attr("class", "panel")
      .attr("width", width)
      .attr("height", height);
      
   var bars = vis.selectAll("g.bar")
      .data(freq)
      .enter().append("svg:g")
        .attr("class", "bar")
        .attr("transform", function(d, i) { return "translate(0," + sc_bin(i) + ")"; });
        
   bars.selectAll("rect.freq")
      .data(function(d,i){ 
/*           if (!i){ 
           alert(d3.zip(d, offSet(d)))
           }
*/         return d3.zip(d, offSet(d));
           return d;
       })
      .enter().append("svg:rect")
         .attr("class", "freq")
         .attr("height", sc_bin.rangeBand())
         .attr("width", function(d){return sc_x(d[0]);})
         .attr("x", function(d){return sc_x(d[1]);})
         .attr("fill", function(d,i) {return pal(i)});
}
    
function offSet(d){
   var cs = [0];
   for (var i = 1; i < d.length; i++){
      cs[i] = cs[i-1] + d[i-1];
   }
   return cs;
}