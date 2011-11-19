class ResyncCoderWallProfileJob
  @queue = :sync
  
  def self.perform(id)
    coder_wall_profile = CoderWallProfile.find(id)
    coder_wall_profile.badges.destroy_all
    coder_wall_profile.sync!
  end

end