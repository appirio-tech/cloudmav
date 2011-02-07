class TalkAddedEvent < Event

  referenced_in :talk, :inverse_of => :events

  def perform
    self.profile.award_badge("Yap yap yap", :description => "For having a talk")
    self.profile.earn("for adding a talk", 10, :speaker_points) 
    self.profile.save
  end

  def set_category
    self.category = "Speaking"
  end

end
