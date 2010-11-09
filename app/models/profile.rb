class Profile
  include Mongoid::Document

  field :name
  field :email
  field :location
  field :lat
  field :lng
  
  referenced_in :user
  
  references_one :stack_overflow_profile
  references_one :speaker_rate_profile
end