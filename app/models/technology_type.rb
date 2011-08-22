class TechnologyType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  references_one :technology, :inverse_of => :technology_type
end
