class Scoring
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :count, :type => Integer
  field :score, :type => Integer
end