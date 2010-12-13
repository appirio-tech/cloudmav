class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.find_by_id(params[:id]).first
    render :not_found if @profile.nil?
  end
  
  private
  
  def has_location?
    !params[:description].blank?
  end
  
  def get_location
    location = Location.new
    location.description = params[:description]
    location.lat = params[:lat]
    location.lng = params[:lng]
    location
  end
end