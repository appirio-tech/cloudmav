class SyncSpeakerRateProfileJob
  @queue = :sync
  
  def self.perform(id)
    speaker_rate_profile = SpeakerRateProfile.find(id)
    profile = speaker_rate_profile.profile
    
    speaker = SpeakerRate.get_speaker(speaker_rate_profile.speaker_rate_id)
    
    speaker_rate_profile.rating = speaker["rating"]
    speaker_rate_profile.url = "http://speakerrate.com/speakers/#{speaker_rate_profile.speaker_rate_id}"

    speaker["talks"].each do |t|
      talk = Talk.where(:speaker_rate_id => t["id"]).first
      if talk.nil?
        talk = Talk.new
        talk.speaker_rate_id = t["id"]
        talk.title = t["title"]
        talk.description = t["info"]["text"]
        talk.presentation_date = DateTime.parse(t["when"])
        talk.talk_creation_date = DateTime.parse(t["when"])
        talk.profile = profile
      end
      talk.has_speaker_rate = true
      talk.speaker_rate_slides_url = t["slides_url"]
      talk.speaker_rating = t["rating"]
      talk.speaker_rate_url = "speakerrate.com/talks/#{t["id"]}"
      talk.save
    end
        
    profile.award_badge("I need validation", :description => "For having a SpeakerRate account")
    profile.save
    
    speaker_rate_profile.last_synced_date = DateTime.now
    speaker_rate_profile.save
    
    profile.calculate_score!  
  end

end