class Meeting
  include Mongoid::Document

  field :title, :type => String
  field :start, :type => DateTime
  field :end, :type => DateTime
  field :summary, :type => String
  
  validates_presence_of :title
  validates_presence_of :summary
  
  embedded_in :user_group
  
  field :lat, :type => Float
  field :lng, :type => Float
  field :location, :type => String
  field :coordinates, :type => Array
  
  index [[ :coordinates, Mongo::GEO2D ]]
  
  before_save :update_coordinates
  
  def update_coordinates
    unless lat.nil? || lng.nil?
      self.coordinates = [lat, lng]
    end
  end
end
