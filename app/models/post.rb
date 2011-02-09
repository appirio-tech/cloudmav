class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  
  field :title, :type => String
  field :written_on, :type => DateTime  
  field :url, :type => String
  
  referenced_in :blog, :inverse_of => :posts
  referenced_in :profile, :inverse_of => :posts
end
