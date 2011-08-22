class BacklogItemAddedEvent < ProfileEvent

  referenced_in :backlog_item, :inverse_of => :events

  def set_profile
    self.profile = backlog_item.author
  end

  def award_badges
    profile.award_badge("Poster boy", :description => "For posting an item on the backlog")
  end

  def description
    "added the '#{backlog_item.title}' to the Backlog"
  end

end
