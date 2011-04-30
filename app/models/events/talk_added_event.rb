class TalkAddedEvent < TalkEvent

  def score_points
    profile.earn("for adding a talk", 10, :speaker_points) 
  end

  def award_badges
    profile.award_badge("Yap yap yap", :description => "For having a talk")
  end

  def description
    "added the talk #{talk.title}"
  end

end
