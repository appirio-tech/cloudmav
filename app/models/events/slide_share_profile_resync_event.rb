class SlideShareProfileResyncEvent < SlideShareProfileSyncEvent

  def before_sync
    talks = Talk.for_profile(profile).where(:imported_from => "SlideShare")
    talks.each do |talk|
      TalkEvent.for_profile(profile).for_talk(talk).destroy_all
      talk.destroy
    end

    SlideShareProfileAddedEvent.for_profile(profile).destroy_all

    profile.recalculate_score!
  end

end



