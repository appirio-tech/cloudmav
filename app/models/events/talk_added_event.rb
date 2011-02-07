class TalkAddedEvent < Event

  referenced_in :talk, :inverse_of => :events

  def perform
    profile.award_badge("Yap yap yap", :description => "For having a talk")
    profile.earn("for adding a talk", 10, :speaker_points) 
    talk.calculate_tags
    profile.save
  end

  def set_category
    self.category = "Speaking"
  end

end
