class GitHubProfile
  include Mongoid::Document
  include Mongoid::Timestamps
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
  has_many :repositories, :inverse_of => :git_hub_profile, :class_name => "GitHubRepository"

  def related_items
    [profile.coder_profile]
  end
  
  def generate_tags
    self.repositories.each do |r|
      import_tags_from(r)
    end
  end
  
end