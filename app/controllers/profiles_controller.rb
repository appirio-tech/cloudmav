class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.find(params[:id])
  end
  
  def edit
    @profile = Profile.find(params[:id])
  end
  
  def update
    @profile = current_user.profile
    if @profile.update_attributes(params)
      flash[:notice] = "Profile updated"
      redirect_to profile_path(@profile)
    else
      render "edit"
    end
  end
  
end