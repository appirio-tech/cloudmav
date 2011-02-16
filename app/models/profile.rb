require 'gravtastic'
require 'score_it'
require 'virgil'

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
  include CodeMav::Locatable
  include CodeMav::Indexable

  is_gravtastic!

  field :api_id, :type => Integer
  field :name, :type => String
  field :email, :type => String
  field :username, :type => String
  index :username, :unique => true
  
  field :can_manage_tags, :type => Boolean, :default => false
  field :is_moderator, :type => Boolean, :default => false
  
  def can_manage_tags?
    can_manage_tags
  end
  
  def moderator?
    is_moderator
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
   
    def stack_overflow
      where(:stack_overflow_profile.exists => true)
    end
    
    def top_stack_overflow
      stack_overflow.desc('stack_overflow_profile.reputation')
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
