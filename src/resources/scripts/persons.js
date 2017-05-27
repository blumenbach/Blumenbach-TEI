$(document).ready(function() {
    $('#persons').DataTable({
            "order": [[ 1, "asc" ]],
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',             
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ] },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },
                { "iDataSort": 2, "sDefaultContent": "-", "targets": [ 2 ] },
            ]        
     });
} );