class GitHubProfile
  include Mongoid::Document
  
  field :git_hub_id
  field :username
  field :gist_count
  field :repository_count
  field :followers_count
  field :url
  
  referenced_in :profile
  
  def synch!
    GitHubService.synch(self)
    save!
  end
end