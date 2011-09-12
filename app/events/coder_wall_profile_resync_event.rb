class CoderWallProfileResyncEvent < CoderWallProfileSyncEvent

  def before_sync
    coder_wall_profile.badges.destroy_all
    profile.recalculate_score!
  end

end


