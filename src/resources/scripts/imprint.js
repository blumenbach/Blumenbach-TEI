$(document).ready(function() {
    $('#imprint').DataTable({
            "order": [[ 1, "asc" ]],
            "iDisplayLength": 100,              
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "stateSave": true,
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ] },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },
                 { "iDataSort": 2, "sDefaultContent": "-", "targets": [ 2 ] },               
                { "visible": false, "sdefaultContent": "-", "targets": [ 3 ] },                
                { "iDataSort": 3, "sDefaultContent": "-", "targets": [ 4 ] },                
            ]        
     });
} );