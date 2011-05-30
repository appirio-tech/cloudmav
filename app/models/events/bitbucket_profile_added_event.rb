class BitbucketProfileAddedEvent < ProfileEvent
  referenced_in :bitbucket_profile, :inverse_of => :events

  def award_badges
    profile.award_badge("Bucketeer", :description => "For having a Bitbucket account")
  end

  def score_points
    profile.earn("for adding Bitbucket", 10, :coder_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Code"
    self.subcategory = "Bitbucket"
  end

  def description
    %Q{added Bitbucket to CodeMav}
  end

  def icon_url
    "event_icons/bitbucket.png"
  end

end

