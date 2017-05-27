$(document).ready(function() {
    $('#objekte-list').DataTable({
            "iDisplayLength": 100,              
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "stateSave": true,
            "columnDefs": [
                { orderData: [ 0, 1 ], "sDefaultContent": "-", targets: [ 0 ] },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },
                { "iDataSort": 2, "sdefaultContent": "-", "targets": [ 2 ] } 
            ]        
     });
} );