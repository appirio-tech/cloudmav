class BlogAddedEvent < ProfileEvent

  referenced_in :blog, :inverse_of => :events

  def award_badges
    profile.award_badge("iBlog", :description => "For having a blog")
  end

  def score_points
    profile.earn("for adding a blog", 10, :writer_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Writing"
    self.subcategory = "Blog"
  end

  def description
    "added blog '#{blog.title}' to CodeMav"
  end

  def icon_url
    "event_icons/blog.png"
  end

end
