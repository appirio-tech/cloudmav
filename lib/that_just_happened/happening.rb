class Happening  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :category, :type => String
  referenced_in :actor, :inverse_of => :occurences, :polymorphic => true
  referenced_in :subject, :inverse_of => :occurence, :polymorphic => true
end