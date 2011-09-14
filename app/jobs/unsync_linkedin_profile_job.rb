class UnsyncLinkedinProfileJob
  @queue = :sync
  
  def self.perform(id)
    linkedin_profile = LinkedinProfile.find(id)
    profile = linkedin_profile.profile
    
    profile.jobs.destroy_all
    linkedin_profile.destroy
    
    profile.calculate_score!
  end

end