require 'taggable'

class Technology
  include Mongoid::Document
  include CodeMav::Taggable
  
  field :name, :type => String
  field :technology_type
  
  scope :named, lambda { |name| where(:name => name) }

end
