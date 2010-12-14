class Talk
  include Mongoid::Document
  
  field :title, :type => String
  field :description, :type => String
  field :slides_url, :type => String
  
  embedded_in :profile, :inverse_of => :talk
  embeds_many :presentations
    
end