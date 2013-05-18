<div class="modal hide" id="uploadForm" style="position: absolute;" max-height="1000px">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3>Upload Your Program</h3>
    </div>

    <div id="ajaxForm">
        <g:render template="uploadForm"/>
    </div>
</div>



<script>
    var origHtml = $('#ajaxForm').html();
$('#uploadForm').on('hidden', function () {
    //reinit the content
    $('#ajaxForm').html(origHtml);

})
</script>