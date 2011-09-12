class TalkEvent < ProfileEvent

  referenced_in :talk, :inverse_of => :events

  scope :for_talk, lambda { |talk| where(:talk_id => talk.id) }

  def set_info
    self.is_public = true
    self.category = "Speaking"
    self.date = talk.talk_creation_date
  end

  def other_work
    talk.retag!
  end

  def icon_url
    talk.preview_pic
  end
end