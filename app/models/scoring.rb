class Scoring
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::HasSubject
  
  field :name, :type => String
  field :point_type, :type => String
  field :score, :type => Integer, :default => 0
  
  embedded_in :scorable, :polymorphic => true
end