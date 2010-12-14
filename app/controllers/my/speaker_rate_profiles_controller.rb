class My::SpeakerRateProfilesController < My::MyController
  
  def new
    @speaker_rate_profile = SpeakerRateProfile.new
  end
  
  def create
    @speaker_rate_profile = SpeakerRateProfile.new(params[:speaker_rate_profile])
    @speaker_rate_profile.profile = current_profile
    @speaker_rate_profile.sync!
        
    redirect_to [:my, current_profile]
  end
  
  def synch
    current_profile.speaker_rate_profile.sync!
    
    redirect_to [:my, current_profile]
  end
  
end