class ProfileEvent < Event

  referenced_in :profile, :inverse_of => :events

  scope :for_profile, lambda { |profile| where(:profile_id => profile.id) }

  def set_profile
    self.profile = subject.profile
  end

  def do_work
    set_profile
    other_work if self.respond_to? :other_work
    score_points if self.respond_to? :score_points
    award_badges if self.respond_to? :award_badges
    profile.save
  end

end
