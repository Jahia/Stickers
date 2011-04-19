 <script type="text/javascript">

    /*Function to delete a sticker*/
	$('.delete').live('click',function(e){

        /*Get the current object*/
        var obj = $(this);

		/* Sending an AJAX POST request to delete the sticker */
        $.ajax({
                    url : "${url.base}${fullPath}/"+$(this).attr('id'),
                    type : "POST",
                    dataType : "json",
                    data : { methodToCall : "delete"},
                    success : function(result) {
						obj.parent().parent().css({'display':'none'});
						obj.parent().parent().remove();
                    }});

        /*Block the redirection*/
        return false;
	});


    /*Function to add a new sticker*/
	$('#sticker-submit').live('click',function(e){

        /*Check the length of the sticker*/
        <%--@todo: Replace by a resource bundle--%>
		if($('.pr-body').val().length<4)
		{
			alert("The sticker text is too short!")
			return false;
		}

		/* Sending an AJAX POST request to create the new sticker */
        $.ajax({
                    url : "${url.base}${fullPath}/*",
                    type : "POST",
                    dataType : "json",
                    data : { nodeType : "jnt:sticker",  text :  $('.pr-body').val(), color : $.trim($('#previewSticker').attr('class').replace('sticker','')), top : 0, left : 0, zindex:++zIndex},
                    success : function(result) {

                          //1- We duplicate
                          var tmp = $('#previewSticker').clone();

                          //2- We initialize the new sticker
                          tmp.attr('id',$(result).attr('j_nodename'));
                          tmp.find('span.data').text($(result).attr('j_nodename')).end().css({'z-index':zIndex,top:0,left:0});
                          tmp.find('div.delete').css({'display':'inherit'});
						  tmp.find('div.delete a').attr('id', $(result).attr('j_nodename'));

                          //3- We add it to the body
                          tmp.appendTo($('div.bodywrapper'));    //not finished

                          //4- We make it draggable
                          make_draggable(tmp);

                          //5- We clear the form and the preview
                          $('.sticker-form :input').val("");
                          $('#previewSticker .body').html("");

                          //6- We close the fancybox
                          //$("#addButton").fancybox.close();
                    }});

        /*Block the redirection*/
        return false;
    });


    /*Function to update position of elements*/
    function make_draggable(elements)
    {
        elements.draggable({
            containment:'parent',
            start:function(e,ui){ ui.helper.css('z-index',++zIndex); },
            stop:function(e,ui){

                /*On stop, send a request with the current position*/
                $.ajax({
                    url : "${url.base}${fullPath}/"+ui.helper.find('span.data').html(),
                    type : "POST",
                    dataType : "json",
                    data : { methodToCall : "put", top: ui.position.top, left : ui.position.left, zindex : zIndex}
                });
            }
        });
    }

</script>

<p class="pAddSticker"><a href="#addStickerForm" class="btn-slide" id="addButton"><img title="" alt="" src="${url.currentModule}/img/note_add.png" align="absmiddle"/> Add a sticker</a></p>
 
<div style="display:none;">
     <div id="addStickerForm" >
            <h3 class="popupTitle">Add a new sticker</h3>

            <!-- The preview: -->
            <div id="previewSticker" class="sticker yellow" style="left:0;top:65px;z-index:1">
                <div class="body"></div>
                <div class="author">${renderContext.user.username}</div>
                <div class="delete" style="display:none;"><a href="" id="" class="delete"></a></div>
                <span class="data"></span>
            </div>

            <div id="stickerData"> <!-- Holds the form -->
                <form action="" method="post" class="sticker-form">
                    <label for="sticker-body">Text of the sticker</label>
                    <textarea name="sticker-body" id="sticker-body" class="pr-body" cols="30" rows="6"></textarea>
                    <label>Color</label> <!-- Clicking one of the divs changes the color of the preview -->
                    <div class="color yellow"></div>
                    <div class="color blue"></div>
                    <div class="color green"></div>
                    <div class="color red"></div>
                    <div class="color pink"></div>
                    <div class="color orange"></div>
                    <!-- The green submit button: -->
                    <a id="sticker-submit" href="" class="stickit-button">Stick it</a>
                </form>
            </div>
     </div>
</div>