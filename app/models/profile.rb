class Profile
  include Mongoid::Document

  field :name
  field :email
  
  referenced_in :user
end