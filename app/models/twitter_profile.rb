class TwitterProfile
  include Mongoid::Document
  include CodeMav::Taggable
  include CodeMav::Eventable
  include CodeMav::Syncable

  field :username, :type => String
  field :url, :type => String
  field :followers_count, :type => Integer

  belongs_to :profile

  validates_presence_of :username

  def related_items
    [profile.social_profile]
  end
  
end
