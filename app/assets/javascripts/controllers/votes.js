jQuery(function()
{
	var container = jQuery('.container');
	var overlay = container.find('.overlay');
	
	// input handlers
	container.on('focus','.new_vote .song input, .new_vote .festival input', function()
	{
		var target = jQuery(this);
		container.find('.preview').hide();
		target.parent().find('.preview').show();
		target.trigger('input');
	});
	
	container.on('click','.new_vote .preview', function()
	{
		var target = jQuery(this);
		target.hide();
	});
	
	container.on('input','.new_vote .video_search, .new_vote .artist_search', function()
	{
		var song = container.find('.new_vote .video_search').val();
		var artist = container.find('.new_vote .artist_search').val();
		youtube_results( artist + ' ' + song, generate_preview );
	});
	
	container.on('input','.new_vote .festival_search', function()
	{
		var target = jQuery(this);
		festival_results( target.val() );
	});
	
	// search handlers
	var festival_results = function( search_for )
	{
		festivals = container.find('.new_vote .festival .preview span');
		
		festivals.each(function()
		{
			
			var target = jQuery(this);
			target.toggle( target.html().search( new RegExp( search_for, "i")) != -1 );
		});
	};
	
	var youtube_results = function( search_for, result_list )
	{
    var url = "http://gdata.youtube.com/feeds/api/videos/?v=2&alt=jsonc&callback=?";
    url = url + '&paid-content=false';
    url = url + '&orderby=viewCount';
    url = url + '&max-results=4';
		
		jQuery.ajax
		({
			url: url + "&q=" + search_for,
			dataType: 'json',
			success: function( result )
			{
				result_list(result.data.items);
			},
			error: function()
			{
				//
			}
		});
			
	};
	
	var generate_preview = function( video_list )
	{
		preview_container = container.find('.new_vote .song .preview');
		preview_container.html('');
		if ( video_list )
		{
			video_list.forEach(function(video)
			{
				preview_container.append('<div class="image search_result" data-video_id="'+ video.id +'" style="background-image:url(\''+ video.thumbnail.hqDefault +'\')" title="'+ video.title +'">');
			});
		}
		
	};
	
	
	// result click handlers
	container.on('click','.song .search_result', function()
	{
		var target = jQuery(this);
		container.find('.new_vote .video_search').val( target.attr('title') );
		container.find('.new_vote .youtube_link').val( target.attr('data-video_id') );
	});
	
	container.on('click','.festival .preview span', function()
	{
		var target = jQuery(this);
		container.find('.new_vote .festival_search').val( target.html() );
		container.find('.new_vote .festival_id').val( target.attr('data-festival_id') );
	});
	
	// validation
	
	container.on('submit','.new_vote',function()
	{
		var form = jQuery(this);
		jQuery.ajax
		({
			type: 'POST',
			format: 'json',
			url:  form.attr('action')+'.json',
			data: form.serialize(),
			dataType: 'json',
			success: function( result )
			{
				if(result.success == true)
				{
					load_success_page( form.find('.artist_search').val(), 'music' );
				}
			},
			error: function()
			{
				//
			}
		});
		
		
		return false;	
	});
	
	container.on('submit','.new_report',function()
	{
		var form = jQuery(this);
		jQuery.ajax
		({
			type: 'POST',
			format: 'json',
			url:  form.attr('action')+'.json',
			data: form.serialize(),
			dataType: 'json',
			success: function( result )
			{
				if(result.success == true)
				{
					load_success_page( form.find('.artist_search').val(), 'manifest' );
				}
			},
			error: function()
			{
				//
			}
		});
		
		
		return false;	
	});
	
	
	
	// after create
	var load_success_page = function(artist, controller)
	{
		var params = artist && controller == 'music' ? '&artist='+artist : '' ;
		jQuery.ajax
		({
			format: 'json',
			url:  '/'+controller+'/success?ajax=1'+params,
			success: function( result )
			{
				overlay.addClass('visible');
				overlay.html(result);
			},
			error: function()
			{
				//
			}
		});
	};
	
});