class ActivitiesController < ApplicationController
  respond_to :json, :xml
  
  def show
    @profile = Profile.find(params[:profile_id])
    @activity = ProfileActivityPresenter.get_activity(@profile)
    respond_with(@activity)
  end
  
end