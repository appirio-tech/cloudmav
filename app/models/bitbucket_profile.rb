class BitbucketProfile
  include Mongoid::Document
  include CodeMav::Eventable
  include CodeMav::Taggable
  include CodeMav::Syncable
  
  field :username
  field :repository_count, :type => Integer
  field :followers_count, :type => Integer
  field :url
  
  belongs_to :profile
  has_many :repositories, :class_name => "BitbucketRepository"

  def related_items
    [profile.coder_profile]
  end

end
