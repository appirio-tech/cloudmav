class ResyncGitHubProfileJob
  @queue = :sync
  
  def self.perform(id)
    git_hub_profile = GitHubProfile.find(id)
    git_hub_profile.repositories.destroy_all
    git_hub_profile.sync!
  end

end