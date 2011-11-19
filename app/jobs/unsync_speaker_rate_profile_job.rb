class UnsyncSpeakerRateProfileJob
  @queue = :sync
  
  def self.perform(id)
    speaker_rate_profile = SpeakerRateProfile.find(id)        
    profile = speaker_rate_profile.profile
    
    talks = Talk.for_profile(profile).from_speaker_rate
    talks.each do |talk|      
      talk.clear_speaker_rate_info!
    end
    
    speaker_rate_profile.destroy
    
    profile.remove_badge("I need validation")
    profile.calculate_score!
  end

end