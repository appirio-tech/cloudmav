class SpeakerRateProfileSynchEvent < SynchEvent
  referenced_in :speaker_rate_profile, :inverse_of => :events

  def synch
    speaker = SpeakerRate.get_speaker(speaker_rate_profile.speaker_rate_id)
    
    speaker_rate_profile.rating = speaker["rating"]
    speaker_rate_profile.url = "http://speakerrate.com/speakers/#{speaker_rate_profile.speaker_rate_id}"

    speaker["talks"].each {|t| create_talk(t) unless already_has_talk?(t) }
    
    speaker_rate_profile.save
  end

  def already_has_talk?(sr_talk)
    profile.talks.where(:imported_id => sr_talk["id"]).first
  end
  
  def create_talk(sr_talk)
    talk = Talk.new
    talk.title = sr_talk["title"]
    talk.description = sr_talk["info"]["text"]
    talk.slides_url = sr_talk["slides_url"]
    talk.imported_id = sr_talk["id"]
    talk.imported_from = "SpeakerRate"
    profile.talks << talk
    talk.save
    
    p = talk.presentations.build(:presentation_date => DateTime.parse(sr_talk["when"]))
    p.save
  end
end
