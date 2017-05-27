// everytime the button is pushed, open the modal, and trigger the shown.bs.modal event
$('#openBtn').click(function () {
    $('#modal-content').modal({
        show: true
    });
});

$("#modal-content").on('hidden.bs.modal', function(){
	alert("Transformation Executed.");
});

$('#executenBtn').click(function () {
    $("#modal-content").modal('hide');
});

