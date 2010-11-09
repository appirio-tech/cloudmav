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
  
  def as_json(opts={})
    { 
      :git_hub_id => git_hub_id,
      :username => username,
      :gist_count => gist_count,
      :repository_count => repository_count,
      :followers_count => followers_count,
      :url => url
    }
  end
end