class SpeakerRateProfilesController < ApplicationController
  
  def new
    @speaker_rate_profile = SpeakerRateProfile.new
  end
  
  def create
    @speaker_rate_profile = SpeakerRateProfile.new(params[:speaker_rate_profile])
    SpeakerRateService.synch(@speaker_rate_profile)
    @speaker_rate_profile.profile = current_profile
    
    current_profile.save!
    @speaker_rate_profile.save!
    
    redirect_to current_profile
  end
  
end