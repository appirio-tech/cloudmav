class AutodiscoverSlideShareEvent < AutodiscoverEvent

  def set_info
    self.discover_type = "SlideShare"
  end

  def discover
    name_to_search = profile.username
    response = SlideShare.get_slideshows_by_user(profile.username)

    if response.success?
      profile.slide_share_profile = SlideShareProfile.new(:slide_share_username => profile.username)
      profile.slide_share_profile.save
      profile.save
      profile.slide_share_profile.sync!
    end
  end

end

