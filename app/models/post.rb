class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  
  field :title, :type => String
  field :written_on, :type => DateTime  
  field :url, :type => String
  field :imported_id, :type => String
  
  belongs_to :blog
  belongs_to :profile
end
