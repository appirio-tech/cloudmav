class SyncEvent < Event
  referenced_in :profile, :inverse_of => :events

  def do_work
    sync
    s = subject
    s.last_synced_date = DateTime.now
    s.save
    award_badges if respond_to?(:award_badges)
  end

  def set_info
    self.is_public = false
    self.category = "Sync"
  end

end
