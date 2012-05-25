var tp = {};

tp.settings = { from : 0
              , to : 100
              };
			  
var varss;

function draw(json){
	varss = json;
	
	var w = $("body").width() - 40,
		h = 600,
		x = d3.scale.linear()
		      .domain([0, 1])
		      .range([0, w]),
		y = d3.scale.ordinal()
		      .domain(d3.range(json.nBins))
		      .rangeBands([0, h]),
		z = d3.scale.linear()
		      .domain([0, 1])
		      .range(["white", "steelblue"]);
          
		
	yAxis = d3.svg.axis().ticks(10).orient("left").tickFormat(d3.format(".1%"));
	yAxis.scale().domain([tp.settings.from/100, tp.settings.to/100]).range([0,h]);
		
  var body = d3.select("body");
	
	var svg = body.select("svg")
      .attr("width", w + 40)
	  .attr("height", h + 50)
      ;
   
	var vis = svg.select("#vis").text("");

	svg.select("g.y.axis")
		  .attr("transform", "translate(10,0)")
		  .call(yAxis);	

    var vars = d3.keys(json.vars);
    
	tp.settings.sortCol = tp.settings.sortCol || vars[0];
	 
    sc_vars = d3.scale.ordinal()
        .domain(d3.range(vars.length))
        .rangeBands([0, w], 0.1);
   
    var names = body.select("div.vars");
    names.select("#offset")
         .style("margin-left", "30px")
         ;
   
    var name = names.selectAll("button")
      .data(vars);
   
    var rb = sc_vars.rangeBand();
   
    name.enter()
      .append("button")
      .style("width", rb + "px")
      .style("margin-left", .1 * rb + "px")
      .text(function(d) {return d;})
	   .on("click", sortVar)
      ;
   
   name.exit().remove();
   
   name.each(function(d){
      var option = {icons:{secondary: "ui-icon-triangle-2-n-s"}};
	  
	  if (d === tp.settings.sortCol){
        if (!tp.settings.decreasing){
	        option.icons = {secondary: "ui-icon-triangle-1-n"};
        } else{
	        option.icons = {secondary: "ui-icon-triangle-1-s"};
        }
	  }
	  
      $(this).button(option);
   })
   
   var cols = vis.selectAll("g.columns")
     .data(vars);
	 
   cols.enter().append("g")
    .classed("columns", true)
	 .classed("numeric", function(d) {return json.vars[d].mean})
	 .classed("categorical", function(d) {return !json.vars[d].mean})
	 ;
   
   cols.exit().remove();
   
   for (var i = 0; i < vars.length; i++){
      v = vars[i];
	  if (json.vars[v].mean){
       numvar(json.vars[v], vis, sc_vars(i), sc_vars.rangeBand(), h, y, z);
     } else {
       cut = json.vars[v];
       catvar(json.vars[v], vis, sc_vars(i), sc_vars.rangeBand(), h, y);
     }
   }   
}
