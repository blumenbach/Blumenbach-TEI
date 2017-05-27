  var network;
  var nodes = new vis.DataSet();
  var edges = new vis.DataSet();
  var gephiImported;
  var fixedCheckbox = document.getElementById('fixed');
  fixedCheckbox.onchange = redrawAll;
  var parseColorCheckbox = document.getElementById('parseColor');
  parseColorCheckbox.onchange = redrawAll;
  var nodeContent = document.getElementById('nodeContent');
  var edgeContent = document.getElementById('edgeContent');
  loadJSON('./resources/scripts/vis/Blumenbach-graph.json', redrawAll, function(err) {console.log('error')});
  var container = document.getElementById('network');
  var data = {
    nodes: nodes,
    edges: edges
  };
  var options = {
    nodes: {
      color: {
          border: '#2B7CE9',
          background: '#97C2FC',
          highlight: {
            border: '#2B7CE9',
            background: '#D2E5FF'
          },
          hover: {
            border: '#2B7CE9',
            background: '#D2E5FF'
          }
      },
      font: {
        face: 'Tahoma'
      },
      shape: 'box',
        shapeProperties: {
          borderDashes: false, // only for borders
        },
      scaling: {
        min: 1,
        max: 100,
        label: {
          enabled: true,
          min: 14,
          max: 100,
          maxVisible: 100,
          drawThreshold: 5
        },
      },
    },
    edges: {
      width: 0.15,
     color: 'gray',      
      smooth: {
        type: 'continuous'
      }
    },
    interaction: {
      tooltipDelay: 200,
      hideEdgesOnDrag: true
    },
    physics: {
      stabilization: false,
      barnesHut: {
        gravitationalConstant: -10000,
        springConstant: 0.002,
        springLength: 150
      }
    },
    value: 10
  };
  network = new vis.Network(container, data, options);
  network.on('click', function (params) {
    if (params.nodes.length > 0) {
      var datanodes = nodes.get(params.nodes[0]); 
      var dataedges = edges.get(params.edges[0]); 
      nodeContent.innerHTML = JSON.stringify(datanodes, undefined, 3); 
      edgeContent.innerHTML = JSON.stringify(dataedges, undefined, 3); 
    }
  })
  /**
   * This function fills the DataSets. These DataSets will update the network.
   */
  function redrawAll(gephiJSON) {
    if (gephiJSON.nodes === undefined) {
      gephiJSON = gephiImported;
    }
    else {
      gephiImported = gephiJSON;
    }
    nodes.clear();
    edges.clear();
    var fixed = fixedCheckbox.checked;
    var parseColor = parseColorCheckbox.checked;
    var parsed = vis.network.gephiParser.parseGephi(gephiJSON, {
      fixed: fixed,
      parseColor: parseColor
    });
    // add the parsed data to the DataSets.
    nodes.add(parsed.nodes);
    edges.add(parsed.edges);
    var datanodes = nodes.get('Johann Friedrich Blumenbach'); // get the data from node 2 as example
    nodeContent.innerHTML = JSON.stringify(datanodes,undefined,3); // show the data in the div
    network.fit(); // zoom to fit
  }

