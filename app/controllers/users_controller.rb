class UsersController < ApplicationController
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
