class Experience
  include Mongoid::Document
  
  field :duration, :type => Duration
  
  embedded_in :profile, :inverse_of => :project
  referenced_in :technology
  
end