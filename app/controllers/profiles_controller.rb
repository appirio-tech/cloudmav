class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.find(params[:id])
  end
  
  def edit
    @profile = Profile.find(params[:id])
  end
  
  def update
    @profile = @user.profile
    if @profile.update_attributes(params)
      flash[:notice] = "Profile updated"
      redirect_to profile_path(@user, @profile)
    else
      render "edit"
    end
  end
  
  private 
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
end