class CoderWallProfileAddedEvent < ProfileEvent
  referenced_in :coder_wall_profile, :inverse_of => :events

  def award_badges
  end

  def score_points
    profile.earn("for adding Coder Wall", 10, :coder_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Code"
    self.subcategory = "CoderWall"
  end

  def description
    "added CoderWall account to CodeMav"
  end

  #def icon_url
    #"event_icons/coderwall.png"
  #end

end

