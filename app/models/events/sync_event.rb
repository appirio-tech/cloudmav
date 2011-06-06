class SyncEvent < Event
  referenced_in :profile, :inverse_of => :events, :index => true

  scope :for_profile, lambda { |profile| where(:profile_id => profile.id) }

  def do_work
    before_sync if respond_to?(:before_sync)
    sync
    s = subject
    s.last_synced_date = DateTime.now
    s.save
    award_badges if respond_to?(:award_badges)
    earn_points if respond_to?(:earn_points)
  end

  def set_info
    self.is_public = false
    self.category = "Sync"
  end

end
