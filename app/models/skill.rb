class Skill
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :tags, :type => Array
end