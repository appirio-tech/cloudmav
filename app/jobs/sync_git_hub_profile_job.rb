class SyncGitHubProfileJob < Resque::JobWithStatus
  @queue = :sync
  
  def perform
    git_hub_profile = GitHubProfile.find(options[:id])
    profile = git_hub_profile.profile
    
    url = URI.parse("http://github.com/api/v2/json/user/show/#{git_hub_profile.username}")
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)

    git_hub_profile.url = "http://www.github.com/#{git_hub_profile.username}"
    git_hub_profile.git_hub_id = result["user"]["id"]
    git_hub_profile.gist_count = result["user"]["public_gist_count"]
    git_hub_profile.repository_count = result["user"]["public_repo_count"]
    git_hub_profile.followers_count = result["user"]["followers_count"]
    git_hub_profile.following_count = result["user"]["following_count"]
    #git_hub_profile.last_synced_date = Time.now

    git_hub_profile.save

    url = URI.parse("http://github.com/api/v2/json/repos/show/#{git_hub_profile.username}")
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)

    result["repositories"].each do |r|
      unless r["fork"]
        find_or_create_repository(git_hub_profile, r)
      end
    end
    
    profile.award_badge("Git R Done", :description => "For having a GitHub account")

    profile.calculate_score!
    git_hub_profile.retag!    
  end
  
  def find_or_create_repository(git_hub_profile, r)
    repository = git_hub_profile.repositories.select{|gr| gr.name == r["name"]}.first 
    repository = GitHubRepository.new(:git_hub_profile => git_hub_profile) unless repository
    repository.name = r["name"]
    repository.url = r["url"]
    repository.description = r["description"]
    repository.creation_date = r["created_at"]
    repository.watchers = r["watchers"]
    repository.forks = r["forks"]
    repository.language = r["language"]
    repository.save
  end
end