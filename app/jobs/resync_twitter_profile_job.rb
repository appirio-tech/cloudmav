class ResyncTwitterProfileJob
  @queue = :sync
  
  def self.perform(id)
    twitter_profile = TwitterProfile.find(id)        
    profile = twitter_profile.profile
    
    profile.calculate_score!
  end

end