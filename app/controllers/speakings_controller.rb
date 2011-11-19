class SpeakingsController < ApplicationController
  before_filter :set_profile
  
  def show
    @tab = "speaking"
  end
  
  def edit
    @tab = "speaking"
    @speaker_rate_profile = @profile.speaker_rate_profile
    @slide_share_profile = @profile.slide_share_profile    
  end
  
end