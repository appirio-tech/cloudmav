class UnsyncCoderWallProfileJob
  @queue = :sync
  
  def self.perform(id)
    coder_wall_profile = CoderWallProfile.find(id)        
    profile = coder_wall_profile.profile
    
    coder_wall_profile.destroy
    
    profile.calculate_score!
  end

end