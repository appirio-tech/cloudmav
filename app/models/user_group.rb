class UserGroup
  include Mongoid::Document

  field :name, :type => String
  
  references_one :location
end