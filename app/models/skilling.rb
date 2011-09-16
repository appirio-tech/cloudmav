class Skilling
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::HasSubject
  
  field :skill_name, :type => String
  field :description, :type => String
  field :score, :type => Integer, :default => 0
  
  embedded_in :skillable, :polymorphic => true
end