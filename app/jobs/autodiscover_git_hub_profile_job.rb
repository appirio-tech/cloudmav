class AutodiscoverGitHubProfileJob
  
  def self.perform(id)
    profile = Profile.find(id)
    profile.autodiscover_histories.create(:name => "GitHub")
        
    name_to_search = profile.username
    url = URI.parse("http://github.com/api/v2/json/user/search/#{name_to_search}")
  
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)
    match = nil
    
    result["users"].each do |github_user|
      unless match
        match = github_user if profile.gravatar_id == github_user["gravatar_id"]
      end
    end

    if match
      profile.location = match["location"] if profile.location.nil?
      profile.git_hub_profile = GitHubProfile.new(:username => match["username"])
      profile.git_hub_profile.save
      profile.save
      profile.git_hub_profile.sync!
    end
  end
  
end