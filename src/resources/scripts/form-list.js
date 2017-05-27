$(document).ready(function() {
    $('#taxon-list').DataTable({
            "order": [[ 1, "asc" ]],
            "iDisplayLength": 10,              
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "stateSave": true,
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ] },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },           
                { "iDataSort": 2, "sDefaultContent": "-", "targets": [ 2 ] },
                { "iDataSort": 3, "sDefaultContent": "-", "targets": [ 3 ] },
                { "iDataSort": 4, "sDefaultContent": "-", "targets": [ 4 ] },                
            ]        
     });
    $('#brief-list').DataTable({
            "order": [[ 1, "asc" ]],
            "iDisplayLength": 10,              
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "stateSave": true,
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ] },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },           
                { "iDataSort": 2, "sDefaultContent": "-", "targets": [ 2 ] },
                { "iDataSort": 3, "sDefaultContent": "-", "targets": [ 3 ] },
                { "iDataSort": 4, "sDefaultContent": "-", "targets": [ 4 ] },                
            ]        
     });  
    $('#werk-list').DataTable({
            "order": [[ 1, "asc" ]],
            "iDisplayLength": 10,              
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "stateSave": true,
            "columnDefs": [
                { "iDataSort": 0, "sDefaultContent": "-", "targets": [ 0 ] },
                { "iDataSort": 1, "sDefaultContent": "-", "targets": [ 1 ] },           
                { "iDataSort": 2, "sDefaultContent": "-", "targets": [ 2 ] },
                { "iDataSort": 3, "sDefaultContent": "-", "targets": [ 3 ] },
                { "iDataSort": 4, "sDefaultContent": "-", "targets": [ 4 ] },                
            ]        
     });     
} );