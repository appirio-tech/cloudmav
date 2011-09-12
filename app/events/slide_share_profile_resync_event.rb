class SlideShareProfileResyncEvent < SlideShareProfileSyncEvent

  def before_sync
    talks = Talk.for_profile(profile).from_slide_share
    talks.each do |talk|
      talk.clear_slide_share_info!
    end

    SlideShareProfileAddedEvent.for_profile(profile).destroy_all

    profile.recalculate_score!
  end

end



