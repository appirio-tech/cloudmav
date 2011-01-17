require 'taggable'

class Technology
  include Mongoid::Document
  include CodeMav::Taggable
  
  field :name
  field :type
  
  scope :named, lambda { |name| where(:name => name) }

end