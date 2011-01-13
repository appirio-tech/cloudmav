class SpeakerRateProfilesController < ApplicationController
  
  def new
    @speaker_rate_profile = SpeakerRateProfile.new
  end
  
  def create
    @speaker_rate_profile = SpeakerRateProfile.new(params[:speaker_rate_profile])
    @speaker_rate_profile.profile = current_profile
    @speaker_rate_profile.synch!
        
    redirect_to [:my, current_profile]
  end
  
end