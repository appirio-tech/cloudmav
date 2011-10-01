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
        
    redirect_to edit_profile_path(@profile)
  end
  
  def edit
    authorize! :sync_profile, @profile
    @speaker_rate_profile = @profile.speaker_rate_profile
  end

  def update
    authorize! :sync_profile, @profile
    @speaker_rate_profile = @profile.speaker_rate_profile
    
    if @speaker_rate_profile.speaker_rate_id == params[:speaker_rate_profile][:speaker_rate_id]
      @speaker_rate_profile.sync!
    else
      if @profile.speaker_rate_profile.update_attributes(params[:speaker_rate_profile])
        @profile.speaker_rate_profile.resync!
      end
    end
    redirect_to edit_profile_path(@profile)
  end

  def destroy
    authorize! :sync_profile, @profile
    @speaker_rate_profile = SpeakerRateProfile.find(params[:id])
    @speaker_rate_profile.unsync!
    redirect_to profile_code_path(@profile)
  end

end
