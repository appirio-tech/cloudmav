class TwitterProfileAddedEvent < ProfileEvent

  referenced_in :twitter_profile, :inverse_of => :events

  def award_badges
    profile.award_badge("Tweeple", :description => "For having a Twitter account")
  end

  def score_points
    profile.earn("for adding Twitter", 10, :social_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Social"
  end

  def description
    "added Twitter account #{twitter_profile.username}"
  end

end

