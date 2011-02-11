class SynchEvent < Event

  referenced_in :profile, :inverse_of => :events

  def set_info
    self.is_public = false
    self.category = "Synch"
  end

end
