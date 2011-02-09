class StackOverflowProfileAddedEvent < Event

  referenced_in :stack_overflow_profile, :inverse_of => :events

  def award_badges
    profile.award_badge("Stack Overflow Junkie", :description => "For having a Stackoverflow account")
  end

  def score_points
    profile.earn("for adding Stack Overflow", 10, :coder_points) 
  end

  def set_info
    self.public = true
    self.category = "Code"
  end

end
