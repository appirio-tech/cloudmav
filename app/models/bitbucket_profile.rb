class BitbucketProfile
  include Mongoid::Document
  include CodeMav::Eventable
  include CodeMav::Taggable
  include CodeMav::Syncable
  
  field :username
  field :repository_count
  field :followers_count
  field :url
  
  referenced_in :profile, :inverse_of => :bitbucket_profile
  references_many :repositories, :inverse_of => :bitbucket_profile, :class_name => "BitbucketRepository"

  def related_items
    [profile.coder_profile]
  end

end
