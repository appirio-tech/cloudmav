class Profile
  include Mongoid::Document

  field :name
  field :email
  
  references_one :user
end