class UnsyncGitHubProfileJob
  @queue = :sync
  
  def self.perform(id)
    git_hub_profile = GitHubProfile.find(id)        
    profile = git_hub_profile.profile
    
    git_hub_profile.repositories.destroy_all
    git_hub_profile.destroy
    
    profile.remove_badge("Git R Done")    
    profile.calculate_score!
  end

end