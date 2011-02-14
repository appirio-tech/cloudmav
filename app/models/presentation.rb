class Presentation
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  
  field :presentation_date, :type => DateTime
  
  referenced_in :talk, :inverse_of => :presentation

end
