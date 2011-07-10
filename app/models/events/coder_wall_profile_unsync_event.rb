class CoderWallProfileUnsyncEvent < UnsyncEvent
  referenced_in :coder_wall_profile, :inverse_of => :events

  def other_work
  end

  def remove_badges
  end

end
