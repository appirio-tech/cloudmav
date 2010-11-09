class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.find_by_id(params[:id]).first
  end
  
  def edit
    @profile = Profile.find_by_id(params[:id]).first
  end
  
  def update
    @profile = current_user.profile
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Profile updated"
      redirect_to profile_path(@profile)
    else
      render "edit"
    end
  end
  
end