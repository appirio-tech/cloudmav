class BitbucketRepository 
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable

  field :name, :type => String
  field :url, :type => String
  field :description, :type => String
  field :followers_count, :type => Integer 

  referenced_in :bitbucket_profile, :inverse_of => :repositories

  def profile
    self.bitbucket_profile.profile
  end

end

