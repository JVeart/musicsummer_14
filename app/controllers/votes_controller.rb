class VotesController < ApplicationController

  def create
    @vote = current_user.votes.build
    @vote.assign_attributes( vote_params )

    respond_to do |format|
      format.html do
        if @vote.save
          redirect_to music_path, :notice => "Vote was successfully created."
        else
          unless params[:ajax].blank?
            render :layout => false
          else
            render :new
          end
        end
      end
      format.json do
        render :json => { :success => @vote.save, :errors => @vote.errors }
      end
    end
  end

  def new

    if current_user.blank?
      redirect_to music_sign_in_path( :ajax => params[:ajax] )
    else
      @vote = current_user.votes.build
      @festivals = Festival.all.reorder( 'name ASC' )

      respond_to do |format|
        format.html do
          unless params[:ajax].blank?
            render :layout => false
          end
        end
      end
    end

  end

  private

  def vote_params
    params.require(:vote).permit( :festival_id, :youtube_link, :artist, :user_attributes => [:id, :contact_mail] )
  end

end
