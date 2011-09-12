class SlideShareProfileSyncEvent < SyncEvent
  referenced_in :slide_share_profile, :inverse_of => :events

  def sync
    response = SlideShare.get_slideshows_by_user(slide_share_profile.slide_share_username)
    talks = get_talks(response)
    talks.each do |ss_talk|
      talk = profile.talks.where(:slide_share_id => ss_talk["ID"]).first
      if talk.nil?
        talk = Talk.new
        talk.title = ss_talk["Title"]
        talk.description = ss_talk["Description"]
        talk.has_slide_share = true
        talk.slide_share_id = ss_talk["ID"]
        talk.presentation_date = DateTime.parse(ss_talk["Created"])
        talk.talk_creation_date = DateTime.parse(ss_talk["Created"])
        talk.profile = profile
      end
      talk.slide_share_thumbnail = ss_talk["ThumbnailURL"]
      talk.slide_share_download_url = ss_talk["DownloadUrl"]
      talk.slideshow_html = ss_talk["Embed"]
      talk.save
    end

    slide_share_profile.url = "http://www.slideshare.net/#{slide_share_profile.slide_share_username}"
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

end
