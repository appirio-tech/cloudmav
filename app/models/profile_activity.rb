class ProfileActivity
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :url
  field :html
  field :date
end