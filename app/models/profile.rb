class Profile
  include Mongoid::Document
  include Badgeable::Subject

  field :api_id, :type => Integer
  field :name
  field :email
  
  referenced_in :user
  
  embeds_one :stack_overflow_profile
  embeds_one :speaker_rate_profile
  embeds_one :git_hub_profile
  embeds_one :location
    
  before_create :set_api_id
  
  scope :find_by_id, lambda { |id| { :where => { :api_id => id } } }
  
  def display_name
    name unless name.nil?
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
  
  protected
  
  def set_api_id
    self.api_id = Profile.count + 1
  end 
  
end