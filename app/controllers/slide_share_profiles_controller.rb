class SlideShareProfilesController < LoggedInController
  
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
  
  def edit
    authorize! :sync_profile, @profile
    @speaker_rate_profile = @profile.speaker_rate_profile
  end

  def update
    authorize! :sync_profile, @profile
    
    if @profile.slide_share_profile.update_attributes(params[:slide_share_profile])
      @profile.slide_share_profile.resync!
      redirect_to profile_speaking_path(@profile)
    else
      render :edit
    end
  end

end
