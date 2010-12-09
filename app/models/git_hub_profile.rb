class GitHubProfile
  include Mongoid::Document
  
  field :git_hub_id
  field :username
  field :gist_count
  field :repository_count
  field :followers_count
  field :url
  
  embedded_in :profile, :inverse_of => :git_hub_profile
  
  def synch!
    GitHubService.synch(self)
    self.profile.save!
    self.save!
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