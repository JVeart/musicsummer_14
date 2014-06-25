class ArtistsController < ApplicationController
  
  def show
    all_votes = Vote.where( "artist = ?", params[:id] )
    @artist = all_votes.limit(1).offset( rand( all_votes.count ) )[0]
    
    respond_to do |format|
      format.html
      format.json do
        render :json => {
                          :artist => @artist.artist,
                          :festival => @artist.festival.name,
                          :youtube_link => @artist.youtube_link,
                          :count => all_votes.count
                        }
      end
    end
  end
  
end
