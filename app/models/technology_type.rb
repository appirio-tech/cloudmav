class TechnologyType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  has_one :technology, :inverse_of => :technology_type
end
