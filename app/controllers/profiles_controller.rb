class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.find_by_id(params[:id]).first
  end
  
  def edit
    @profile = Profile.find_by_id(params[:id]).first
    redirect_to @profile unless @profile == current_profile
  end
  
  def update
    @profile = current_profile
    @profile.update_attributes(params[:profile])
    # @profile.location = get_location if has_location?
    
    if @profile.save!
      flash[:notice] = "Profile updated"
      redirect_to @profile
    else
      render "edit"
    end
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