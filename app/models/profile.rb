class Profile
  include Mongoid::Document

  field :api_id, :type => Integer
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
    
  before_create :set_api_id
  before_save :update_coordinates
  
  scope :find_by_id, lambda { |id| { :where => { :api_id => id } } }
  
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
  
  protected
  
  def set_api_id
    puts "test"
    self.api_id = Profile.count + 1
    puts "api id is #{api_id}"
  end 
  
  def update_coordinates
    unless lat.nil? || lng.nil?
      puts "update #{lat}, #{lng}"
      self.coordinates = [lat, lng]
    end
  end
  
end