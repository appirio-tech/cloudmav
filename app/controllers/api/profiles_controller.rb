class Api::ProfilesController < ApplicationController
  respond_to :json
  
  def show
    @profile = Profile.where(:api_id => params[:id])
    respond_with(@profile)
  end
  
end