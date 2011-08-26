class UnsyncEvent < Event
  referenced_in :profile, :inverse_of => :events, :index => true

  scope :for_profile, lambda { |profile| where(:profile_id => profile.id) }

  def set_profile
    self.profile = Profile.find(subject.profile.id)
  end

  def do_work
    set_profile
    other_work if self.respond_to? :other_work
    remove_badges if respond_to?(:remove_badges)
    remove_tags if respond_to?(:remove_tags)
    subject.destroy
    profile.recalculate_score!
  end

  def set_info
    self.is_public = false
    self.category = "Sync"
  end

  def remove_badge(badge_name)
    badge = Badge.where(:name => badge_name).first
    unless badge.nil?
      badging = profile.badgings.where(:badge_id => badge.id).first
      badging.destroy unless badging.nil?
    end
  end

end

