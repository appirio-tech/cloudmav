class TwitterProfile
  include Mongoid::Document
  
  field :username, :type => String
  field :followers_count, :type => Integer
  
end