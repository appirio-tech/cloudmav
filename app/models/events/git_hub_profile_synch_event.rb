require 'net/http'
require 'json'

class GitHubProfileSynchEvent < SynchEvent
  referenced_in :git_hub_profile, :inverse_of => :events

  def do_work
    url = URI.parse("http://github.com/api/v2/json/user/show/#{git_hub_profile.username}")
    
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)

    git_hub_profile.url = "http://www.github.com/#{git_hub_profile.username}"
    git_hub_profile.git_hub_id = result["user"]["id"]
    git_hub_profile.gist_count = result["user"]["public_gist_count"]
    git_hub_profile.repository_count = result["user"]["public_repo_count"]
    git_hub_profile.followers_count = result["user"]["following_count"]
    git_hub_profile.save
  end

end
