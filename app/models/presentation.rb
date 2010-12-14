class Presentation
  include Mongoid::Document
  
  field :presentation_date, :type => DateTime
  
  embedded_in :talk, :inverse_of => :presentation

end