class TagGitHubProfileJob < TagJob
  
  def set_taggable(git_hub_profile_id)
    @taggable = GitHubProfile.find(git_hub_profile_id)
  end
  
  def tag
    @taggable.repositories.each do |r|
      unless r.language.blank?
        @taggable.tag r.language.downcase, :score => 10
      end
    end  
  end

end