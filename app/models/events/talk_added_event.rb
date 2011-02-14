class TalkAddedEvent < ProfileEvent

  referenced_in :talk, :inverse_of => :events

  def score_points
    profile.earn("for adding a talk", 10, :speaker_points) 
  end

  def award_badges
    profile.award_badge("Yap yap yap", :description => "For having a talk")
  end

  def set_info
    self.is_public = true
    self.category = "Speaking"
  end

  def description
    "Added the talk #{talk.title}"
  end

end
