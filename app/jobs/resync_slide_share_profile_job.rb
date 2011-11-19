class ResyncSlideShareProfileJob
  @queue = :sync
  
  def self.perform(id)
    slide_share_profile = SlideShareProfile.find(id)
    profile = slide_share_profile.profile
    
    talks = Talk.for_profile(profile).from_slide_share
    talks.each do |talk|      
      talk.clear_slide_share_info!
    end

    slide_share_profile.sync!
  end

end