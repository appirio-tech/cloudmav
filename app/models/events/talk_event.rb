class TalkEvent < ProfileEvent

  referenced_in :talk, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Speaking"
  end

  def other_work
    talk.retag!
  end

end
