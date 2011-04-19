var zIndex = 900;

$(document).ready(function(){
	/* This code is executed after the DOM has been completely loaded */

	var tmp;
    
	$('.sticker').each(function(){
		/* Finding the biggest z-index value of the stickers */

		tmp = $(this).css('z-index');
		if(tmp>zIndex) zIndex = tmp;
	})

	/* A helper function for converting a set of elements to draggables: */
	make_draggable($('.sticker'));

	/* Configuring the fancybox plugin for the "Add a sticker" button: */
	$("#addButton").fancybox({
		'zoomSpeedIn'		: 600,
		'zoomSpeedOut'		: 500,
		'easingIn'			: 'easeOutBack',
		'easingOut'			: 'easeInBack',
		'hideOnContentClick': false,
		'padding'			: 15
	});

	/* Listening for keyup events on fields of the "Add a sticker" form: */
	$('.pr-body').live('keyup',function(e){

		if(!this.preview)
			this.preview=$('#previewSticker');

		/* Setting the text of the preview to the contents of the input field, and stripping all the HTML tags: */
		this.preview.find($(this).attr('class').replace('pr-','.')).html($(this).val().replace(/<[^>]+>/ig,''));
	});

	/* Changing the color of the preview sticker: */
	$('.color').live('click',function(){

		$('#previewSticker').removeClass('yellow green blue red pink orange').addClass($(this).attr('class').replace('color',''));
	});

    
});

