<div class="modal-body" style="max-height: 800px;">

    <g:if test="${flash?.error}">
        <div class="alert alert-error">
            <strong>Failure!</strong> ${flash.error}
        </div>
    </g:if>

    <form action="/home/doUpload" method="POST" id="thisForm" name="thisForm" enctype="multipart/form-data">

        <p>To compete, you'll need to upload your program.</p>
        <label>Program Challenge</label>
        <g:challengesDropdown selected="${challenge}"/>

        <label>Your Program</label>
        <input type="file" name="program">


        <hr>

        <p><strong>We Need to Know This Stuff Too</strong></p>


        <label>Your ID (we can't check this, so make sure it is right!)</label>
        <input type="text" name="pid" value="${pid}" placeholder="Your Pid (Including Letter)">

        <label>Your Full Name</label>
        <input type="text" name="name" value="${name}">


        <label>Your Email</label>
        <input type="text" name="email" value="${email}">
        <br>
        We use your email to display your picture via Gravitar. <br>Want your pic to show up? <a
            href="http://en.gravatar.com/" target="_blank">Get a gravitar!</a>

        <hr>

        <p><strong>Last but not least...</strong></p>

        <input type="checkbox" name="agree"
               value="Y"> AlgoSlam will display my program on the web (after the deadline). I'm good with this.

    </form>
</div>

<div class="modal-footer">
    <span id="form-indicator" style="display: none;"><img src="/images/indicator.gif"></span>
    <a href="#" class="btn" data-dismiss="modal">Close</a>
    <a href="#" onclick="uploadProgram();
    return false;" class="btn btn-primary">Upload</a>
</div>



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