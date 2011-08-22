class Api::V1::ProfilesController < ApplicationController
  respond_to :json, :xml
  
  def show
    @profile = Profile.where(:username => params[:id]).first
    respond_with(@profile)
  end

  def tags
    @profile = Profile.where(:username => params[:id]).first
    respond_with(@profile)
  end
  
end
