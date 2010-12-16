class Technology
  include Mongoid::Document
  
  field :name
  field :is_language
  
  scope :named, lambda { |name| where(:name => name) }
  
end