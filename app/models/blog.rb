class Blog
  include Mongoid::Document
  
  field :title, :type => String
  field :url, :type => String
  
  embeds_many :posts
  embedded_in :profile, :inverse_of => :blog
    
end