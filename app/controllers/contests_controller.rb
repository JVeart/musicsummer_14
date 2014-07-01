class ContestsController < ApplicationController
  
  def show
    @contest = Report.where( 'name = ?', params[:id] )
    
    respond_to do |format|
      format.html
      format.json do
        render :json => {
                          :name => @contest.name,
                          :image => @contest.image_link,
                          :contest_link => @contest.contest_link,
                        }
      end
    end
  end
  
end
