class ManifestController < ApplicationController
  def index
    @contests = Report.all.confirmed
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
  
  def sign_in
    
    respond_to do |format|
      format.html do
        unless params[:ajax].blank?
          render :layout => false
        end
      end
    end
  end
  
end
