class GitHubProfile
  include Mongoid::Document
  
  field :git_hub_id
  field :username
  field :gist_count
  field :repository_count
  field :followers_count
  field :url
  
  referenced_in :profile, :inverse_of => :git_hub_profile
  references_many :events, :inverse_of => :git_hub_profile

  after_create :add_git_hub

  def add_git_hub
    GitHubProfileAddedEvent.create(:profile => profile, :git_hub_profile => self)
  end

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
