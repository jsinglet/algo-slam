<div class="modal-body">

    <h3>Success!</h3>

    <p>Congrats! Your program has been uploaded. It should run shortly, but if it doesn't, feel free to send an email to me at <a
            href="mailto:jsinglet@gmail.com">jsinglet@gmail.com</a>.</p>

</div>

<div class="modal-footer">
    <span id="form-indicator" style="display: none;"><img src="/images/indicator.gif"></span>
    <a href="#" class="btn btn-success" data-dismiss="modal">Close</a>
</div>

<script type="text/javascript">
    (function worker2() {
        jQuery.ajax({
            url: '${createLink(action:'queue')}',
            success: function(data) {
                jQuery('#queueContainer').html(data);
            },
            complete: function() {
                // setTimeout(worker, 2000);
            }
        })
    })();
</script>


<script type="text/javascript">
    var ido = false;

    var uploadProgram = function() {
        if (!ido) {
            ido = true;

            $("#form-indicator").show();

            $('#thisForm').ajaxSubmit(
                    {   url: '/home/doUpload',
                        success: function(d) {
                            ido = false;

                            $('#ajaxForm').html(d);
                            eval($('#ajaxForm').find("script").text());

                        },
                        error: function() {
                            ido = false;

                            alert('There was an error processing your request. Please try again in a few moments')
                            $("#form-indicator").hide();

                        }
                    }

            );

        }
    }




</script>