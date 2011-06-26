class SpeakerRateProfileUnsyncEvent < UnsyncEvent
  referenced_in :speaker_rate_profile, :inverse_of => :events

  def other_work
    talks = Talk.for_profile(profile).where(:imported_from => "SpeakerRate")
    talks.each do |talk|
      TalkEvent.for_profile(profile).for_talk(talk).destroy_all
      talk.destroy
    end

    SpeakerRateProfileAddedEvent.for_profile(profile).destroy_all

    profile.recalculate_score!
  end

  def remove_badges
    remove_badge("I need validation")
  end

end


