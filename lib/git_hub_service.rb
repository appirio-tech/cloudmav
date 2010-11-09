require 'net/http'
require 'json'

class GitHubService
  
  def self.synch(profile)
    url = URI.parse("http://github.com/api/v2/json/user/show/#{profile.username}")
    
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)

    profile.url = "http://www.github.com/#{profile.username}"    
    profile.git_hub_id = result["user"]["id"]
    profile.gist_count = result["user"]["public_gist_count"]
    profile.repository_count = result["user"]["public_repo_count"]
    profile.followers_count = result["user"]["following_count"]
  end
  
end