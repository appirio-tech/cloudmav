class SpeakerRateProfileAddedEvent < ProfileEvent

  referenced_in :speaker_rate_profile, :inverse_of => :events

  def award_badges
    profile.award_badge("I need validation", :description => "For having a SpeakerRate account")
  end

  def score_points
    profile.earn("for adding Speaker Rate", 10, :speaker_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Speaker"
  end

  def description
    "Added SpeakerRate account"
  end

end
