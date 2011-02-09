require 'geokit'
require 'gravtastic'
require 'score_it'
require 'virgil'
require 'profile_modules/writer_module'
require 'profile_modules/speaker_module'
require 'profile_modules/experience_module'
require 'taggable'

class Profile
  include Mongoid::Document
  include Badgeable::Subject
  include Gravtastic
  include ScoreIt::Subject 
  include Virgil::Teachable
  include CodeMav::WriterModule
  include CodeMav::SpeakerModule
  include CodeMav::ExperienceModule
  include CodeMav::Taggable

  is_gravtastic!

  field :api_id, :type => Integer
  field :name, :type => String
  field :email, :type => String
  field :username, :type => String
  index :username, :unique => true
  
  field :lat, :type => Float
  field :lng, :type => Float
  field :location, :type => String
  field :coordinates, :type => Array
  field :can_manage_tags, :type => Boolean, :default => false
  field :is_moderator, :type => Boolean, :default => false
  
  index [[ :coordinates, Mongo::GEO2D ]]
  
  before_save :update_coordinates
  before_save :add_to_index
  
  def can_manage_tags?
    can_manage_tags
  end
  
  def moderator?
    is_moderator
  end
  
  def add_to_index
    Sunspot.index!(self) unless Rails.env.test?
  end
  
  def update_coordinates
    unless lat.nil? || lng.nil?
      self.coordinates = [lat, lng]
    end
  end
  
  referenced_in :user
  references_many :activities
  
  references_one :stack_overflow_profile
  references_one :speaker_rate_profile
  references_one :slide_share_profile
  references_one :git_hub_profile
  references_one :linkedin_profile
    
  scope :by_username, lambda { |uname| { :where => { :username => uname } } }
  
  def username
    self.user.username
  end
  
  def display_name
    (self.name.blank? || self.name.nil?) ? self.username : self.name
  end
  
  def to_param
    username
  end

  def location_text
    return "not set" if location.nil?
    location
  end
  
  def as_json(opts={})
    result = { 
      :id => api_id,
      :username => username,
      :name => name
    }
    result[:stack_overflow] = stack_overflow_profile.as_json unless stack_overflow_profile.nil?
    result[:git_hub] = git_hub_profile.as_json unless git_hub_profile.nil?
    result[:speaker_rate] = speaker_rate_profile.as_json unless speaker_rate_profile.nil?
    return result
  end
  
  def synch!
    stack_overflow_profile.synch! unless stack_overflow_profile.nil?
    git_hub_profile.synch! unless git_hub_profile.nil?
    speaker_rate_profile.synch! unless speaker_rate_profile.nil?
    slide_share_profile.synch! unless slide_share_profile.nil?
  end
  
  def just(name, subject, options= {})
    options[:category] ||= "general"
    a = Activity.new(:name => name, :category => options[:category])
    a.subject = subject
    self.activities << a
  end
  
  def calculate_tags
        calculate_speaker_tags
    calculate_experience_tags
  end
  
  class << self
    def synch_all!
      Profile.all.each do |p|
        begin
          p.synch!
          rescue
            puts "ERROR on synching #{p.display_name}'s profile"
        end
      end
    end
    
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
    
    def geocode(location)
      response = Geokit::Geocoders::MultiGeocoder.geocode(location)
      return [response.lat, response.lng]
    end

    def search(query, options = {})
      coordinates = (options[:near].nil? || options[:near].blank?) ? nil : geocode(options[:near])

      search = Sunspot.new_search(Profile)
      search.build do
        if coordinates
          with(:coordinates).near(coordinates.first, coordinates.last, :precision => 2, :precision_factor => 2, :boost => 200)
        end
        keywords query do
        end
      end
      search.execute
    end
  end
  
end
