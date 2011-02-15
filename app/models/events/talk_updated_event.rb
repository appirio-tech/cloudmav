class TalkUpdatedEvent < TalkEvent

  def description
    "Updated the talk #{talk.title}"
  end

end

