class ArtistsController < ApplicationController
  
  def show
    artist = params[:id].gsub("-", " ")
    voted = !current_user.blank? ? Vote.where( "artist = ? AND user_id = ?", artist, current_user.id ).first : nil
    all_votes = Vote.where( "artist = ? AND youtube_link IS NOT NULL", artist )
    @artist = all_votes.limit(1).offset( rand( all_votes.count ) )[0]
    
    respond_to do |format|
      format.html
      format.json do
        render :json => {
                          :artist => @artist.artist,
                          :festival => @artist.festival.name,
                          :youtube_link => @artist.youtube_link,
                          :count => all_votes.count,
                          :liked => !voted.blank?
                        }
      end
    end
  end
  
  def vote
    
    unless current_user.blank?
      vote_for = Vote.where( "artist = ?", params[:id] ).first
    
      @vote = current_user.votes.build
      @vote.artist = vote_for.artist
    end
    
    respond_to do |format|
      format.html
      format.json do
        render :json => { :success => !current_user.blank? && @vote.save, :errors => !current_user.blank? ? @vote.errors : { :sign_in => false } }
      end
    end
  end
  
end
