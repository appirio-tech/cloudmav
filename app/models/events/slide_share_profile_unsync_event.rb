class SlideShareProfileUnsyncEvent < UnsyncEvent
  referenced_in :slide_share_profile, :inverse_of => :events

  def other_work
    talks = Talk.for_profile(profile).from_slide_share
    talks.each do |talk|
      talk.clear_slide_share_info!
    end

    SlideShareProfileAddedEvent.for_profile(profile).destroy_all

    profile.recalculate_score!
  end

  def remove_badges
    remove_badge("Sliding along")
  end

end



