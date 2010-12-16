class Technology
  include Mongoid::Document
  
  field :name
  field :is_language
  
  scope :named, lambda { |name| where(:name => name) }
  # references_many :projects, :stored_as => :array, :inverse_of => :technologies
end