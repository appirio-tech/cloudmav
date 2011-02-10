class TalkAddedEvent < ProfileEvent

  referenced_in :talk, :inverse_of => :events

  def do_work
    talk.find_tags_in(talk.title, Tag.all)
    talk.find_tags_in(talk.description, Tag.all)
  end

  def score_points
    profile.earn("for adding a talk", 10, :speaker_points) 
  end

  def award_badges
    profile.award_badge("Yap yap yap", :description => "For having a talk")
  end

  def set_info
    self.public = true
    self.category = "Speaking"
  end

end
