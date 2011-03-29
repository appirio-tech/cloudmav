class StackOverflowProfileAddedEvent < ProfileEvent

  referenced_in :stack_overflow_profile, :inverse_of => :events

  def award_badges
    profile.award_badge("Stack Junkie", :description => "For having a Stackoverflow account")
  end

  def score_points
    profile.earn("for adding Stack Overflow", 10, :coder_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Code"
  end

  def description
    "added StackOverflow account to CodeMav"
  end

end
