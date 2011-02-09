class GitHubProfileAddedEvent < Event

  referenced_in :git_hub_profile, :inverse_of => :events

  def award_badges
    profile.award_badge("Git R Done", :description => "For having a GitHub account")
  end

  def score_points
    profile.earn("for adding GitHub", 10, :coder_points) 
  end

  def set_info
    self.public = true
    self.category = "Code"
  end

end
