class GitHubRepository 
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :url, :type => String
  field :description, :type => String
  field :creation_date, :type => String
  field :watchers, :type => Integer 
  field :forks, :type => Integer 
  field :language, :type => String

  belongs_to :git_hub_profile, :inverse_of => :repositories

  def profile
    self.git_hub_profile.profile
  end

end
