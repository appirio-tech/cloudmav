class SlideShareProfileUnsyncEvent < UnsyncEvent
  referenced_in :slide_share_profile, :inverse_of => :events

  def other_work
    talks = Talk.for_profile(profile).where(:imported_from => "SlideShare")
    talks.each do |talk|
      TalkEvent.for_profile(profile).for_talk(talk).destroy_all
      talk.destroy
    end

    SlideShareProfileAddedEvent.for_profile(profile).destroy_all

    profile.recalculate_score!
  end

  def remove_badges
    remove_badge("Sliding along")
  end

end



