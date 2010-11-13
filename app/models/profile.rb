require 'geokit'
require 'gravtastic'

class Profile
  include Mongoid::Document
  include Badgeable::Subject
  include Gravtastic

  is_gravtastic!

  field :api_id, :type => Integer
  field :name, :type => String
  field :email, :type => String
  
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
  
  referenced_in :user
  
  embeds_one :stack_overflow_profile
  embeds_one :speaker_rate_profile
  embeds_one :git_hub_profile
    
  before_create :set_api_id
  
  scope :find_by_id, lambda { |id| { :where => { :api_id => id } } }
  
  def display_name
    return self.name unless self.name.blank?
    return self.email unless self.email.blank?
    user.email
  end
  
  def to_param
    "#{api_id}"
  end
  
  def as_json(opts={})
    result = { 
      :id => api_id,
      :name => name
    }
    result[:stack_overflow] = stack_overflow_profile.as_json unless stack_overflow_profile.nil?
    result[:git_hub] = git_hub_profile.as_json unless git_hub_profile.nil?
    result[:speaker_rate] = speaker_rate_profile.as_json unless speaker_rate_profile.nil?
    return result
  end
  
  class << self
    def near_loc(location)
      response = Geokit::Geocoders::MultiGeocoder.geocode(location)
      near(:coordinates => [response.lat, response.lng, 1])
    end
    
    def stack_overflow
      where(:stack_overflow_profile.exists => true)
    end
    
    def top_stack_overflow
      stack_overflow.desc('stack_overflow_profile.reputation')
    end
  end
  
  protected
  
  def set_api_id
    self.api_id = Profile.count + 1
  end 
  
end