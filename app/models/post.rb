class Post
  include Mongoid::Document
  
  field :title, :type => String
  field :written_on, :type => DateTime  
  
end