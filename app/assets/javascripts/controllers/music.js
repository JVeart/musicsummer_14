jQuery(function()
{
	var iOS = ( navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false );
	var container = jQuery('.container');
	
	var copy_buttons = container.find('.share .button');
	var top_link = container.find('.top_link');
	var copy_field = container.find('.copy_field');
	
	var links = container.find( '.ajax_link' );
	var artists = container.find( '.artists a' );
	var overlay = container.find( '.overlay' );
	var player_container = container.find( '.player' );
	
	// button overrides
	
	links.on('click', function()
	{
		var target = jQuery(this);
		
		jQuery.ajax
		({
			format: 'json',
			url:  target.attr('href')+'?ajax=1',
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
		
		return false;	
	});
	
	artists.on('click', function()
	{
		var target = jQuery(this);
		
		jQuery.ajax
		({
			format: 'json',
			url:  target.attr('href')+'.json',
			success: function( result )
			{
				render_player( result, target );
			},
			error: function()
			{
				//
			}
		});
		
		return false;	
	});
	
	// share buttons
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
	
	// player
	
	var tag = document.createElement('script');
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	var player;
	var video_ids = [];
	
	function onPlayerStateChange(event){
		switch (event.data)
		{
			case -1:
				//unstarted
			break;
			case 0:
				//stoped
				if( player_container.find( '.play' ).is('.playing') )
				{
					player_container.find( '.play' ).removeClass('playing');
				}
			break;
			case 1:
				//playing
				if( !player_container.find( '.play' ).is('.playing') )
				{
					player_container.find( '.play' ).addClass('playing');
				}
			break;
			case 2:
				//pause
				if( player_container.find( '.play' ).is('.playing') )
				{
					player_container.find( '.play' ).removeClass('playing');
				}
			break;
		}
	}
	
	function onPlayerReady(event)
	{
		player.loadPlaylist(video_ids, 0, 0, "default");
    event.target.playVideo();
		
		player_container.find( '.play' ).click(function()
		{
			var target = jQuery(this);
			var playing = target.is('.playing');
			
			if( playing )
			{
				player.pauseVideo();
			}
			else
			{
				player.playVideo()
			}
			
			target.toggleClass('playing', !playing);
		});
		
		player_container.find( '.previous' ).click(function()
		{
			player.previousVideo();
		});
		player_container.find( '.next' ).click(function()
		{
			player.nextVideo();
		});
		
	}
	
	function onYouTubeIframeAPIReady()
	{
		player = new YT.Player('player',
		{
			height: '225',
			width: '400',
			events:
			{
				'onReady': onPlayerReady,
				'onStateChange': onPlayerStateChange
			}
		});
	}
	
	var render_player = function( item, target )
	{
		player_container.find('.video').html('<div id="player"></div>');
		player_container.css(
												{
													top: target.offset().top + target.height()/2,
													left: target.offset().left + target.width()/2,
												});
		player_container.addClass( 'visible' );
		player_container.find( '.festival' ).html(item.festival);
		player_container.find( '.artist' ).html(item.artist);
		player_container.find( '.count' ).html(item.count);
		player_container.find( '.vote' ).attr('action', '/artists/'+item.artist+'/vote');
		player_container.find( '.vote' ).toggleClass('liked', item.liked );
		
		video_ids = [item.youtube_link];
		onYouTubeIframeAPIReady();
		
	};
	
	container.click(function(e)
	{
		var target = jQuery(e.target);
		
		if ( !target.is('.player') && target.parents('.player').length != 1 )
		{
			player_container.removeClass( 'visible' );
			player_container.find('.video').html('<div id="player"></div>');
		}
	});
	
	container.on('click', '.vote', function()
	{
		var target = jQuery(this);
		
		jQuery.ajax
		({
			type: 'POST',
			format: 'json',
			url:  target.attr('action')+'.json',
			success: function( result )
			{
				if ( result.success )
				{
					var count = target.find('.count');
					count.html( count.html()*1 + 1 );
					target.addClass('liked');
				}
			},
			error: function()
			{
				//
			}
		});
		
	});
	
});