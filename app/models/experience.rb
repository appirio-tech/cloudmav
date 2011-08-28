require 'duration/mongoid'

class Experience
  include Mongoid::Document
  
  field :name, :type => String
  field :duration, :type => Duration
  
  scope :with, lambda { |name| where(:name => name) }
  
  embedded_in :profile, :inverse_of => :project
  belongs_to :technology
  
end
