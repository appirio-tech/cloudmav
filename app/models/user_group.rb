class UserGroup
  include Mongoid::Document

  field :name, :type => String
  
  embeds_many :meetings
  
  def schedule_new_meeting
    meetings.build(:lat => self.lat, :lng => self.lng, :location => self.location, :coordinates => self.coordinates)
  end
  
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