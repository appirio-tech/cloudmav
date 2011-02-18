class SlideShareProfileAddedEvent < ProfileEvent

  referenced_in :slide_share_profile, :inverse_of => :events

  def award_badges
    profile.award_badge("Sliding along", :description => "For having a SlideShare account")
  end

  def score_points
    profile.earn("for adding SlideShare", 10, :speaker_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Speaker"
  end

  def description
    "Added SlideShare account"
  end

end

