class TalkEvent < ProfileEvent

  referenced_in :talk, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Speaking"
  end

  def other_work
    talk.retag!
  end

  def icon_url
    if talk.slides_thumbnail.nil?
      return super
    else
      talk.slides_thumbnail
    end
  end
end
