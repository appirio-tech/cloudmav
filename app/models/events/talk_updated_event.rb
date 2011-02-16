class TalkUpdatedEvent < TalkEvent

  def description
    "Updated the talk #{talk.title}"
  end

  def set_info
    super
    self.is_public = false
  end

end

