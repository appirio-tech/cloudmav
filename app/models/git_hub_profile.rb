class GitHubProfile
  include Mongoid::Document
  include CodeMav::Eventable
  include CodeMav::Taggable
  include CodeMav::Syncable
  
  field :git_hub_id, :type => String
  field :username
  field :gist_count, :type => Integer
  field :repository_count, :type => Integer
  field :followers_count, :type => Integer
  field :following_count, :type => Integer
  field :url
  
  belongs_to :profile
  references_many :repositories, :inverse_of => :git_hub_profile, :class_name => "GitHubRepository"

  def related_items
    [profile.coder_profile]
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
