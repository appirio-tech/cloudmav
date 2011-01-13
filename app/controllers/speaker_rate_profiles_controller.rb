class SpeakerRateProfilesController < ApplicationController
  before_filter :set_profile, :only => [:new, :create]
  
  def new
    authorize! :set_speaker_rate_profile, @profile
    @speaker_rate_profile = SpeakerRateProfile.new
  end
  
  def create
    authorize! :set_speaker_rate_profile, @profile
    @speaker_rate_profile = SpeakerRateProfile.new(params[:speaker_rate_profile])
    @speaker_rate_profile.profile = @profile
    @speaker_rate_profile.synch!
        
    redirect_to profile_speaking_path(@profile)
  end
  
end