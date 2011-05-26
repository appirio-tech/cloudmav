class PostAddedEvent < ProfileEvent

  referenced_in :post, :inverse_of => :events

  def score_points
    profile.earn("for adding a post", 5, :writer_points) 
  end

  def set_info
    self.is_public = true
    self.category = "Writing"
    self.subcategory = "Blog"
    self.date = post.written_on
  end

  def description
    "added post '#{post.title}' to CodeMav"
  end

end
