jQuery(function()
{
	var container = jQuery('.container');
	
	var copy_buttons = container.find('.share .button');
	var top_link = container.find('.top_link');
	
	if (container.is('.controller-coming_soon'))
	{
		copy_buttons.click(function()
		{
			var target = jQuery(this);
			
			var doc = document;
			var text = target.siblings('.copy_field')[0]; 
	
			var selection = window.getSelection();            
			var range = doc.createRange();
			range.selectNodeContents(text);
			selection.removeAllRanges();
			selection.addRange(range);
		});
		
		top_link.click(function()
		{
			jQuery('body,html').animate(
			{
				scrollTop: 0
			}, 400);
		});
	}
});