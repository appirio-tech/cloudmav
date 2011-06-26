class SpeakerRateProfilesController < LoggedInController
  
  def new
    authorize! :sync_profile, @profile
    @speaker_rate_profile = SpeakerRateProfile.new
  end
  
  def create
    authorize! :sync_profile, @profile
    @speaker_rate_profile = SpeakerRateProfile.new(params[:speaker_rate_profile])
    @speaker_rate_profile.profile = @profile
    @speaker_rate_profile.sync!
        
    redirect_to profile_speaking_path(@profile)
  end
  
  def edit
    authorize! :sync_profile, @profile
    @speaker_rate_profile = @profile.speaker_rate_profile
  end

  def update
    authorize! :sync_profile, @profile
    
    if @profile.speaker_rate_profile.update_attributes(params[:speaker_rate_profile])
      @profile.speaker_rate_profile.resync!
      redirect_to profile_speaking_path(@profile)
    else
      render :edit
    end
  end

end
