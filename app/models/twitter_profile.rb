class TwitterProfile
  include Mongoid::Document
  include CodeMav::Eventable
  include CodeMav::Synchable

  field :username, :type => String
  field :url, :type => String
  field :followers_count, :type => Integer

  referenced_in :profile, :inverse_of => :twitter_profile

  validates_presence_of :username
  
end
