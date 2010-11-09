class Profile
  include Mongoid::Document

  field :name
  field :email
  field :location, :type => String
  field :coordinates, :type => Array
  field :lat, :type => Float
  field :lng, :type => Float
  
  referenced_in :user
  
  references_one :stack_overflow_profile
  references_one :speaker_rate_profile
  references_one :git_hub_profile
  
  index [[ :coordinates, Mongo::GEO2D ]]
    
  # before_create :update_coordinates
  before_save :update_coordinates
  
  def update_coordinates
    puts "update #{lat}, #{lng}"
    self.coordinates = [lat, lng]
  end
end