$(document).ready(function() {
    $('#emphs').DataTable({
            "order": [[ 1, "asc" ]],    
            "iDisplayLength": 100,
            "stateSave": true,
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
     });
} );