$(document).ready(function() {
    $('#briefs-grouped').DataTable({
            "ajax": "/rest/db/apps/blumenbach/modules/allbriefs.xql",
            "deferRender": true,           
            "stateSave": true,
            "iDisplayLength": 100,             
            "sDom": '<"top"flip>rt<"bottom"p><"clear">',
            "stateSave": true,            
            "columns": [
                { "data": "ID" },
                { "data": "dsort" },
                { "data": "date" },
                { "data": "asort" },
                { "data": "author.surname", "defaultContent": "author" },
                { "data": "esort" },
                { "data": "empfanger.surname", "defaultContent": "empfanger" },
                { "data": "title" },                
            ]          

     });
} );