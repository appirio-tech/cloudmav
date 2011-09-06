class SpeakerRateProfileUnsyncEvent < UnsyncEvent
  referenced_in :speaker_rate_profile, :inverse_of => :events

  def other_work
    talks = Talk.for_profile(profile).from_speaker_rate
    talks.each do |talk|
      talk.clear_speaker_rate_info!
    end

    SpeakerRateProfileAddedEvent.for_profile(profile).destroy_all

    profile.recalculate_score!
  end

  def remove_badges
    remove_badge("I need validation")
  end

end


