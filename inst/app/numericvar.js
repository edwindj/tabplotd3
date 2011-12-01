
function numvar(data, container, offset, width, sc_bin, sc_complete){

sc_x = d3.scale.linear()
       .domain([0, d3.max(data.mean)])
       .range([0, width]);

var vis = container.append("svg:g")
    .attr("class", "numvar")
    .attr("transform", "translate("+offset+")");

vis.append("svg:rect")
   .attr("class", "panel")
   .attr("width", width)
   .attr("height", sc_bin(99))
   .style("fill", "silver");
var bars = vis.selectAll("g.bar")
    .data(data.mean)
  .enter().append("svg:g")
    .attr("class", "bar")
    .attr("transform", function(d, i) { return "translate(0," + sc_bin(i) + ")"; });
bars.append("svg:rect")
    .attr("fill", function(d,i){return sc_complete(data.compl[i])})
    .attr("width", sc_x)
    .attr("height", sc_bin.rangeBand());

bars.append("svg:line")
    .style("stroke-width", 1)
    .style("stroke", "steelblue")
    .attr("x1", sc_x)
    .attr("x2", sc_x)
    .attr("y1", 0)
    .attr("y2", sc_bin.rangeBand());
    
    return vis;
}