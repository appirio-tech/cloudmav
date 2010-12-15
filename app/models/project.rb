class Project
  include Mongoid::Document
  
  field :name, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :technologies, :type => Array
  
  embedded_in :profile, :inverse_of => :project
      
end