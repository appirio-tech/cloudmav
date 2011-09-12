class TagGitHubProfileJob
  @queue = :tag
  
  def self.perform(git_hub_profile_id)    
    git_hub_profile = GitHubProfile.find(git_hub_profile_id)
    git_hub_profile.clear_tags!

    git_hub_profile.repositories.each do |r|
      unless r.language.blank?
        git_hub_profile.tag r.language.downcase, :score => 10
      end
    end    
  end

end