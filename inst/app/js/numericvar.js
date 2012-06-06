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
				return d3.zip(d, offSet(d));
           return d;
       })
      .enter().append("svg:rect")
         .attr("class", "freq")
         .attr("height", sc_bin.rangeBand())
         .attr("width", function(d){return sc_x(d[0]);})
         .attr("x", function(d){return sc_x(d[1]);})
         .attr("fill", function(d,i) {return pal(i)});
}

function numvar(data, container, offset, width, height, sc_bin, sc_complete){

console.log(data)
sc_x = d3.scale.linear()
       .domain([0, d3.max(data.mean)])
       .range([0, width]);

var vis = container.append("svg:g")
    .attr("class", "numvar")
    .attr("transform", "translate("+offset+")");

vis.append("svg:rect")
   .attr("class", "panel")
   .attr("width", width)
   .attr("height", height);
   
var bars = vis.selectAll("g.bar")
    .data(data.mean)
  .enter().append("svg:g")
    .attr("class", "bar")
    .attr("transform", function(d, i) { return "translate(0," + sc_bin(i) + ")"; });
    
bars.append("svg:rect")
    .attr("fill", function(d,i){return sc_complete(data.compl[i])})
    .attr("width", sc_x)
    .attr("height", sc_bin.rangeBand())
    .attr("title", function(d){return d;})
 ;

	
bars.append("svg:line")
    .style("stroke-width", 1)
    .style("stroke", "steelblue")
    .attr("x1", sc_x)
    .attr("x2", sc_x)
    .attr("y1", 0)
    .attr("y2", sc_bin.rangeBand());

var rules = vis.selectAll("g.rule")
    .data(sc_x.ticks(3))
  .enter().append("svg:g")
    .attr("class", "rule")
    .attr("transform", function(d) { return "translate(" + sc_x(d) + ",0)"; });

rules.append("svg:line")
    .attr("y1", 0)
    .attr("y2", height)
    .attr("stroke", "white")
    .attr("stroke-opacity", .3);
    return vis;
}