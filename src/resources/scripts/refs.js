$(document).ready(function() {
    $('#refs').DataTable({
            "order": [[ 0, "asc" ]],
            "iDisplayLength": 100,             
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',             
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ] },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },
                { "iDataSort": 2, "sDefaultContent": "-", "targets": [ 2 ] },
                { "iDataSort": 3, "sDefaultContent": "-", "targets": [ 3 ] },
                { "iDataSort": 4, "sDefaultContent": "-", "targets": [ 4 ] },                 
            ]        
     });
} );