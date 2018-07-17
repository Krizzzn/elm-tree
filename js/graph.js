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
      node.mass = 100;
      node.color = colors.blue;
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
  }

  var typeEx = /^[A-Z]+/;

  for (var i = tree.nodes.length - 1; i >= 0; i--) {
    var node = tree.nodes[i];
    node.label = "[" + node.id + "] " + node.name;

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
        nodeDistance: 220
      }
    },
    layout: {
      hierarchical: {
        enabled: true,
        //nodeSpacing: 600,
        //nodeDistance: 600,
        levelSeparation:150,
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
};