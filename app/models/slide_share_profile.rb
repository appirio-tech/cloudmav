class SlideShareProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Syncable
  
  field :slide_share_username
  field :url
  field :slides_count, :type => Integer, :default => 0
  
  belongs_to :profile
  
end
