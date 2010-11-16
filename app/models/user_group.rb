class UserGroup
  include Mongoid::Document

  field :name, :type => String
  
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