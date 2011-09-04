class SpeakerRateProfileSyncEvent < SyncEvent
  referenced_in :speaker_rate_profile, :inverse_of => :events

  def sync
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
        talk.creation_date = DateTime.parse(t["when"])
      end
      talk.speaker_rate_slides_url = t["slides_url"]
      talk.speaker_rating = t["rating"]
      talk.speaker_rate_url = "speakerrate.com/talks/#{t["id"]}"
      talk.save
    end
    speaker_rate_profile.save
  end

end
