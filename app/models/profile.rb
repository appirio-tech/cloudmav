class Profile
  include Mongoid::Document

  field :name
  field :email
  
  referenced_in :user
  
  references_one :stack_overflow_profile
end