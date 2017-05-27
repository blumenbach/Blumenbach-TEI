$(document).ready(function() {
    $('#works-grouped').DataTable({
            "order": [[ 2, "asc" ]],
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "iDisplayLength": 100,            
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ] },            
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },
                { "visible": false, "sdefaultContent": "-", "targets": [ 2 ] },                
                { "iDataSort": 2, "sDefaultContent": "-", "targets": [ 3 ] },                
            ]        
     });
} );