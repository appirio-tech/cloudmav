class SynchEvent < Event

  referenced_in :profile, :inverse_of => :events

  def do_work
    synch
    award_badges if respond_to?(:award_badges)
  end

  def set_info
    self.is_public = false
    self.category = "Synch"
  end

end
