class Location
  include Mongoid::Document
  
  field :lat, :type => Float
  field :lng, :type => Float
  field :description, :type => String
  field :coordinates, :type => Array
  
  embedded_in :parent, :inverse_of => :location
  
  index [[ :coordinates, Mongo::GEO2D ]]
  
  before_save :update_coordinates
  
  protected
  
  def update_coordinates
    unless lat.nil? || lng.nil?
      self.coordinates = [lat, lng]
    end
  end
end