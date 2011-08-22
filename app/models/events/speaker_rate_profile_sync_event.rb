class SpeakerRateProfileSyncEvent < SyncEvent
  referenced_in :speaker_rate_profile, :inverse_of => :events

  def sync
    speaker = SpeakerRate.get_speaker(speaker_rate_profile.speaker_rate_id)
    
    speaker_rate_profile.rating = speaker["rating"]
    speaker_rate_profile.url = "http://speakerrate.com/speakers/#{speaker_rate_profile.speaker_rate_id}"

    speaker["talks"].each {|t| create_talk(t) unless already_has_talk?(t) }
    
    speaker_rate_profile.save
  end

  def already_has_talk?(sr_talk)
    profile.talks.where(:imported_id => sr_talk["id"], :imported_from => "SpeakerRate").first
  end
  
  def create_talk(sr_talk)
    profile.talks.create(
      :title => sr_talk["title"],
      :description => sr_talk["info"]["text"],
      :slides_url => sr_talk["slides_url"],
      :imported_id => sr_talk["id"],
      :imported_from => "SpeakerRate",
      :speaker_rating => sr_talk["rating"],
      :presentation_date => DateTime.parse(sr_talk["when"]),
      :talk_creation_date => DateTime.parse(sr_talk["when"]))
  end
end
