class Presentation
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  
  field :presentation_date, :type => DateTime
  field :audience, :type => String
  field :url, :type => String
  
  referenced_in :talk, :inverse_of => :presentations

end
