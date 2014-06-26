class MusicController < ApplicationController
  def index
    @votes = Vote.all.group( :artist ).order('count_all desc').count.keys
  end
  
  def about
    
    respond_to do |format|
      format.html do
        unless params[:ajax].blank?
          render :layout => false
        end
      end
    end
  end
  
  def success
    
    respond_to do |format|
      format.html do
        unless params[:ajax].blank?
          render :layout => false
        end
      end
    end
  end
  
end
