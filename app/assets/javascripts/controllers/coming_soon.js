jQuery(function()
{
	var iOS = ( navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false );
	var container = jQuery('.container');
	
	var copy_buttons = container.find('.share .button');
	var top_link = container.find('.top_link');
	var copy_field = container.find('.copy_field');
	
	if (container.is('.controller-coming_soon'))
	{
		copy_buttons.click(function()
		{
			var target = jQuery(this);
			target.siblings('.copy_field').trigger('click'); 
		});
		
		copy_field.click(function()
		{
			if(iOS)
			{
				this.setSelectionRange(0, this.value.length);
			}
			else
			{
				this.select();
			}
		});
		
		top_link.click(function()
		{
			jQuery('body,html').animate(
			{
				scrollTop: 0
			}, 400);
			return false;
		});
	}
});