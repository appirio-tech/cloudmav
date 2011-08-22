class TalkUpdatedEvent < TalkEvent

  def description
    "Updated the talk #{talk.title}"
  end

  def set_info
    self.is_public = false
    self.category = "Speaing"
  end

end

