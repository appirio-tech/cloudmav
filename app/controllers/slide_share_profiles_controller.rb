class SlideShareProfilesController < LoggedInController
  
  def new
    authorize! :sync_profile, @profile
    @slide_share_profile = SlideShareProfile.new
  end
  
  def create
    authorize! :sync_profile, @profile
    @slide_share_profile = SlideShareProfile.new(params[:slide_share_profile])
    @slide_share_profile.profile = @profile
    @slide_share_profile.sync!
        
    redirect_to edit_profile_path(@profile)
  end
  
  def edit
    authorize! :sync_profile, @profile
    @speaker_rate_profile = @profile.speaker_rate_profile
  end

  def update
    authorize! :sync_profile, @profile
    
    @slide_share_profile = @profile.slide_share_profile
    if @slide_share_profile.slide_share_username == params[:slide_share_profile][:slide_share_username]
      @slide_share_profile.sync!
    else
      if @profile.slide_share_profile.update_attributes(params[:slide_share_profile])
        @profile.slide_share_profile.resync!
      end
    end
    
    redirect_to edit_profile_path(@profile)    
  end

  def destroy
    authorize! :sync_profile, @profile
    @slide_share_profile = SlideShareProfile.find(params[:id])
    @slide_share_profile.unsync!
    redirect_to edit_profile_path(@profile)
  end

end
