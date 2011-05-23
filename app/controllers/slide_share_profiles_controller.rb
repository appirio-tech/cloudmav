class SlideShareProfilesController < ApplicationController
  before_filter :set_profile, :only => [:new, :create]
  
  def new
    authorize! :set_slide_share_profile, @profile
    @slide_share_profile = SlideShareProfile.new
  end
  
  def create
    authorize! :set_slide_share_profile, @profile
    @slide_share_profile = SlideShareProfile.new(params[:slide_share_profile])
    @slide_share_profile.profile = @profile
    @slide_share_profile.sync!
        
    redirect_to profile_speaking_path(@profile)
  end
  
end