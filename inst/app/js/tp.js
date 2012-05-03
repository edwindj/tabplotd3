var tp = {};

tp.settings = { from : 0
              , to : 100
              };

function draw(json){
	var data = d3.range(100).map(Math.random);
	
	var w = $("body").width() - 40,
		 h = 600,
		 x = d3.scale.linear()
		      .domain([0, 1])
		      .range([0, w]),
		 y = d3.scale.ordinal()
		      .domain(d3.range(data.length))
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

   vars = d3.keys(json.vars);

   
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
      .text(function(d) d)
		.on("click", sortVar)
      ;
   
   name.exit().remove();
   
   $("button").button();
   
   /*$("button").width(sc_vars.rangeBand()*1.1);*/
   
   /*var labels = vis.append("svg:g")
	   .attr("class", "labels");

   labels.selectAll("text")
      .data(vars)
	  .enter().append("text")
	    .attr("class", "label")
	  .text(function(d,i) {return d;})
        .attr("x", sc_vars)
		.on("click", sortVar)
		.call(highlightText)
		;
	*/  	  
   for (var i = 0; i < vars.length; i++){
      v = vars[i];
	  if (json.vars[v].mean){
       numvar(json.vars[v], vis, sc_vars(i), sc_vars.rangeBand(), h, y, z);
     } else {
       cut = json.vars[v];
       catvar(json.vars[v], vis, sc_vars(i), sc_vars.rangeBand(), h, y);
     }
   }
   
   // svg.selectAll("rect.bla")
     // .data([0])
     // .enter()
       // .append("rect")
         // .attr("class", "bla")
         // .attr("height", 300)
         // .attr("width", 300)
         // .attr("x", 0)
         // .attr("fill", "red")
         // .attr("y", 0)
     // ;
}
