class ReportsController < ApplicationController
  
  def create
    @report = current_user.reports.build
    @report.assign_attributes( report_params )
    
    respond_to do |format|
      format.html do
        if @report.save
          redirect_to manifest_path, :notice => "Report was successfully created."
        else
          unless params[:ajax].blank?
            render :layout => false
          else
            render :new
          end
        end
      end
      format.json do
        render :json => { :success => @report.save, :errors => @report.errors }
      end
    end
  end
  
  def new
    
    if current_user.blank?
      redirect_to manifest_sign_in_path( :ajax => params[:ajax] )
    else
      @report = current_user.reports.build
      
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

  def report_params
    params.require(:report).permit( :contest_link, :name )
  end
  
end
