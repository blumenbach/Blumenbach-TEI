$(document).ready(function() {
    $('#briefs-grouped').DataTable({
            "order": [[ 1, "asc" ]],
            "iDisplayLength": 100,             
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "stateSave": false,            
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ], "sWidth": "5%" },            
                { "visible": true, "sdefaultContent": "-", "targets": [ 1 ],"sWidth": "15%" },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 2 ], "sWidth": "15%" },
                { "visible": false, "sDefaultContent": "-", "aTargets": [ 3 ] },
                { "iDataSort": 3, "sDefaultContent": "-", "aTargets": [ 4 ], "sWidth": "20%"},                
                { "visible": false, "sDefaultContent": "-", "aTargets": [ 5 ] },
                { "iDataSort": 5, "sDefaultContent": "-", "aTargets": [ 6 ], "sWidth": "20%" },
                { "sDefaultContent": "-", "aTargets": [ 7 ] }                
            ]        
     });
} );