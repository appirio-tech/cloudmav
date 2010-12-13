class Post
  include Mongoid::Document
  
  field :title, :type => String
  field :written_on, :type => DateTime  
  
  embedded_in :blog, :inverse_of => :post
  
end