class UnsyncTwitterProfileJob
  @queue = :sync
  
  def self.perform(id)
    twitter_profile = TwitterProfile.find(id)        
    profile = twitter_profile.profile
    
    twitter_profile.destroy
    
    profile.calculate_score!
  end

end