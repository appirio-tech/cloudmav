class Occurence  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :category, :type => String
  embedded_in :actor, :inverse_of => :occurences
  embedded_in :subject, :inverse_of => :occurence
end