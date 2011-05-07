class SlideShareProfileSynchEvent < SynchEvent
  referenced_in :slide_share_profile, :inverse_of => :events

  def synch
    response = SlideShare.get_slideshows_by_user(slide_share_profile.slide_share_username)
    talks = get_talks(response)
    talks.each do |ss_talk|
      create_talk(ss_talk) unless has_talk?(ss_talk)
    end
    slide_share_profile.url = "http://www.speakerrate.net/#{slide_share_profile.slide_share_username}"
    slide_share_profile.slides_count = talks.count
    profile.save!
    slide_share_profile.save!
  end

  def get_talks(response)
    slideshow = response["User"]["Slideshow"]
    if slideshow.is_a? Hash
      return [slideshow]
    else
      return slideshow
    end
  end

  def has_talk?(ss_talk)
    profile.talks.where(:imported_id => ss_talk["ID"], :imported_from => "SlideShare").any?
  end
  
  def create_talk(ss_talk)
    profile.talks.create(
      :title => ss_talk["Title"],
      :description => ss_talk["Description"],
      :imported_id => ss_talk["ID"],
      :imported_from => "SlideShare",
      :presentation_date => DateTime.parse(ss_talk["Created"]),
      :talk_creation_date => DateTime.parse(ss_talk["Created"]),
      :slides_url => ss_talk["DownloadUrl"],
      :slides_thumbnail => ss_talk["ThumbnailURL"],
      :slideshow_html => ss_talk["Embed"])
  end

end
