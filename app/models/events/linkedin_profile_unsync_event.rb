class LinkedinProfileUnsyncEvent < UnsyncEvent
  referenced_in :linkedin_profile, :inverse_of => :events

  def other_work
    profile.jobs.destroy_all
    JobAddedEvent.for_profile(profile).destroy_all
  end

  def remove_badges
  end

end




