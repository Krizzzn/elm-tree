var Graph = function(tree) {

  if (!document.getElementById('network'))
    return;

  var colors = {
    blue: '#0083BF',
    purple: '#7F3F98',
    green: '#00A886',
    pink: '#EE2375',
    orange: '#FAA21B',
    coolgray06: '#ABA7A7',
    coolgray09: '#78777A',
    coolgray11: '#55565A',
    white: "#FFFFFF"
  };

  var shadeColor = function(color, percent) {
    var f=parseInt(color.slice(1),16),t=percent<0?0:255,p=percent<0?percent*-1:percent,R=f>>16,G=f>>8&0x00FF,B=f&0x0000FF;
    return "#"+(0x1000000+(Math.round((t-R)*p)+R)*0x10000+(Math.round((t-G)*p)+G)*0x100+(Math.round((t-B)*p)+B)).toString(16).slice(1);
  }

  var blendColors = function(c0, c1, p) {
    var f=parseInt(c0.slice(1),16),t=parseInt(c1.slice(1),16),R1=f>>16,G1=f>>8&0x00FF,B1=f&0x0000FF,R2=t>>16,G2=t>>8&0x00FF,B2=t&0x0000FF;
    return "#"+(0x1000000+(Math.round((R2-R1)*p)+R1)*0x10000+(Math.round((G2-G1)*p)+G1)*0x100+(Math.round((B2-B1)*p)+B1)).toString(16).slice(1);
  }

  var progress = function(prg) {
    if (!prg)
      return "";

    var progress = Math.max(0, Math.min(prg, 100));
    if (isNaN(progress))
        return "";

    var filled = Math.floor(progress / 10);

    var d = ""
    for (var i = 0; i < 10; i++) {
        if (i < filled)
            d += "⚫"
        else
            d += "⚪"
    }

    return "\n\r" +d+ " "+ Math.floor(progress) + "%";
  }

  var setNodeStyle = function(node, type) {

    node.font = { "color": colors.white };
    node.margin = 10;
    node.fixed = {y: true};
    node.chosen = {
      label: false,
      node:  function(values, id, selected, hovering) {
        values.shadowSize = 16;
        //    values.borderWidth = 1;
      }
    };

    switch (type){
      case "VISION":
      node.mass = 1000;
      node.color = colors.blue;
      node.x = 0;
      node.y = 0;
      node.physics = false;
      //node.shape = "box";
      break;
      case "SO":
      node.color = colors.coolgray06;
      break;
      case "CSF":
      node.color = colors.coolgray09;
      break;
      case "PRJ":
      node.color = colors.green;
      break;
      case "NC":
      default:
      node.color = colors.coolgray11;
      break;
    }
    if (node.year){
        node.borderWidth = node.borderWidthSelected = 4;
        node.margin = 15;
        node.color = shadeColor(node.color, -0.3)
    }
  }

  var typeEx = /^[A-Z]+/;

  for (var i = tree.nodes.length - 1; i >= 0; i--) {
    var node = tree.nodes[i];
    node.label = "[" + node.id + "] " + node.name + progress(node.progress)

//    if (node.description)
//        node.label += "\n▶▶▶";

    var type = (typeEx.exec(node.id) || ["any"])[0];
    setNodeStyle(node, type);
  }

  // create an array with nodes
  var nodes = new vis.DataSet(tree.nodes);

  // create an array with edges
  var edges = new vis.DataSet(tree.edges);

  // create a network
  var container = document.getElementById('network');
  var data = {
    nodes: nodes,
    edges: edges
  };

  var shadow = {
    enabled: true,
    size: 7,
    x: 0,
    y: 3
  };

  var zoomable = true;

  var options = {
    interaction: {
      selectable: zoomable,
      dragNodes: false,
      dragView: zoomable,
      zoomView: zoomable
    },
    edges: {
      font: {
        size: 12
      },
      width: 3,
      arrows:'to',
      color: { highlight: colors.blue },
      labelHighlightBold: false
    },
    nodes: {
      shape: 'box',
      labelHighlightBold: false,
      margin: 5,
      color: '#7BE141',
      borderWidth: 0,
      borderWidthSelected: 0,
      shadow: shadow,
      widthConstraint: {
        maximum: 200
      }
    },

    physics: {
      enabled: true,
      hierarchicalRepulsion: {
        nodeDistance: 220,
        springLength: 150,
        springConstant: 0.0005
      }
    },
    layout: {
      hierarchical: {
        enabled: true,
        //nodeSpacing: 600,
        //nodeDistance: 600,
        levelSeparation:180,
        blockShifting: false,
        edgeMinimization: false,
        direction: "DU",
        sortMethod: "directed"

      }
    }
  };

  var network = new vis.Network(container, data, options);
  var timeout = null;

  network.on("doubleClick", function(e){
    window.clearTimeout(timeout);
    if (e.nodes.length > 0)
      app.ports.selectNode.send(e.nodes[0]);
    else
      app.ports.selectNode.send("VISION");
  });

  network.on("click", function(e){
    window.clearTimeout(timeout);

    var nodeId = "---";
    if (e.nodes.length > 0)
      nodeId = e.nodes[0];

    timeout = window.setTimeout(function(){
      app.ports.showNode.send(nodeId);
    }, 100);
  });

  if (edges.length > 35) // only show loading bar if some amount of edges are shown.
  {
    network.on("stabilizationProgress", function(params) {

      document.getElementById('bar').style.display = 'block';
      document.getElementById('loadingBar').style.opacity = 1;
      document.getElementById('loadingBar').style.display = 'block';

      var maxWidth = 496;
      var minWidth = 20;
      var widthFactor = params.iterations/params.total;
      var width = Math.max(minWidth,maxWidth * widthFactor);

      document.getElementById('bar').style.width = width + 'px';
    });

    network.on("stabilizationIterationsDone", function() {
      document.getElementById('bar').style.width = '496px';
      document.getElementById('loadingBar').style.opacity = 0;
      setTimeout(function () {document.getElementById('loadingBar').style.display = 'none';}, 300);
    });
  }
  else
  {
    document.getElementById('loadingBar').style.display = 'none';
  }

};