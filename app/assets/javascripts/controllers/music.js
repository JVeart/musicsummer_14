jQuery(function()
{
	var iOS = ( navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false );
	var container = jQuery('.container');
	
	
	var top_link = jQuery('body').find('.top_link');
	
	var overlay = container.find( '.overlay' );
	var player_container = container.find( '.player' );
	
	var scroll_pos = 0;
	// button overrides
	
	jQuery('body').on('click', '.ajax_link', function()
	{
		var target = jQuery(this);
		
		jQuery.ajax
		({
			format: 'json',
			url:  target.attr('href')+'?ajax=1',
			success: function( result )
			{
				scroll_pos = jQuery('body,html').scrollTop();
				jQuery('body,html').animate({scrollTop: 0},300);
				overlay.addClass('visible');
				var controller_path = target.attr('href').split('/');
				var controller_name = controller_path[controller_path.length];
				overlay.attr('data-controller', controller_name);
				overlay.html(result);
			},
			error: function()
			{
				//
			}
		});
		
		return false;	
	});
	
	container.on('click', '.artist a', function()
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
	jQuery('body').on('click','.share .button', function()
	{
		var target = jQuery(this);
		target.siblings('.copy_field').trigger('click'); 
	});
	
	jQuery('body').on('click','.copy_field', function()
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
	
	var check_hash = function()
	{
		if ( window.location.hash )
		{
			setTimeout(function()
			{
				container.find( '.artists .artist a[href$="'+window.location.hash.substr(1)+'"]' ).trigger('click');
				history.pushState(null, null, window.location.href.split('#')[0]);
			},500);
			
		}	
	};
	
	var tag = document.createElement('script');
	
	if(tag.readyState)
	{  //IE
    tag.onreadystatechange = function()
		{
      if ( tag.readyState === "loaded" || tag.readyState === "complete" ) {
        tag.onreadystatechange = null;
        check_hash();
      }
    };
  }
	else
	{  //Others
    tag.onload = function() {
      check_hash();
			
    };
  }
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
		while(typeof YT === 'undefined')
		{
		
		}
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
	
	container.on('click', '.player .vote', function()
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
				else if (!result.success && result.errors.sign_in == false )
				{
					jQuery.ajax
					({
						format: 'json',
						url:  '/music/sign_in?ajax=1',
						success: function( result )
						{
							scroll_pos = jQuery('body,html').scrollTop();
							jQuery('body,html').animate({scrollTop: 0},300);
							overlay.addClass('visible');
							var controller_name = 'sign_in'
							overlay.attr('data-controller', controller_name);
							overlay.html(result);
						},
						error: function()
						{
							//
						}
					});
				}
			},
			error: function()
			{
				//
			}
		});
		
	});
	
	container.on('click', '.overlay', function(e)
	{
		var target = jQuery(this);
		var event_target = jQuery(e.target);
		if ( target[0] == event_target[0] || target.children('div')[0] == event_target[0] )
		{
			jQuery('body,html').animate({scrollTop: scroll_pos },300);
			overlay.removeClass('visible');
		}
	});
	
	container.on('click', '.start_player', function()
	{
		container.find( '.artists .artist a' ).first().trigger('click');
	});
	
});