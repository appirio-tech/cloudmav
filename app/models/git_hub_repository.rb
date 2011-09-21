class GitHubRepository 
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Scorable
  include CodeMav::Skillable

  field :name, :type => String
  field :url, :type => String
  field :description, :type => String
  field :creation_date, :type => String
  field :watchers, :type => Integer 
  field :forks, :type => Integer 
  field :language, :type => String

  belongs_to :git_hub_profile, :inverse_of => :repositories
  has_many :talks

  def profile
    self.git_hub_profile.profile
  end
  
  def related_items
    [git_hub_profile]
  end
  
  def generate_tags
    unless language.nil?
      tag language
    end
  end

end
