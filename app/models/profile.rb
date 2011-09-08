require 'gravtastic'
require 'score_it'
require 'virgil'

class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Badgeable::Subject
  include Gravtastic
  include ScoreIt::Subject 
  include Virgil::Teachable
  include CodeMav::WriterModule
  include CodeMav::SpeakerModule
  include CodeMav::CoderModule
  include CodeMav::KnowledgeModule
  include CodeMav::ExperienceModule
  include CodeMav::SocialModule
  include CodeMav::Taggable
  include CodeMav::Locatable
  include CodeMav::Indexable
  include CodeMav::Followable
  include CodeMav::HasBacklogItems
  include CodeMav::Autodiscoverable

  gravtastic

  field :showcase, :type => Boolean, :default => false
  field :api_id, :type => Integer
  field :name, :type => String
  field :email, :type => String
  field :username, :type => String
  field :gravatar_id, :type => String
  index :username, :unique => true
  
  field :can_manage_tags, :type => Boolean, :default => false
  field :is_moderator, :type => Boolean, :default => false
  
  def gravatar_id
    Digest::MD5.hexdigest(self.email)
  end

  def can_manage_tags?
    can_manage_tags
  end
  
  def moderator?
    is_moderator
  end
  
  belongs_to :user

  scope :by_username, lambda { |uname| where(:username => uname) }
  scope :named, lambda { |name| { :where => { :name => name } } }
  scope :showcase, lambda { where(:showcase => true) }
  
  def display_name
    (self.name.blank? || self.name.nil?) ? self.username : self.name
  end
  
  def to_param
    username
  end

  def sync!
    stack_overflow_profile.sync! unless stack_overflow_profile.nil?
    git_hub_profile.sync! unless git_hub_profile.nil?
    bitbucket_profile.sync! unless bitbucket_profile.nil?
    speaker_rate_profile.sync! unless speaker_rate_profile.nil?
    slide_share_profile.sync! unless slide_share_profile.nil?
    twitter_profile.sync! unless twitter_profile.nil?
  end

  
  class << self
    def sync_all!
      profiles_to_sync = Profile.all.to_a
      profiles_to_sync.each do |p|
        begin
          p.sync!
        rescue
            puts "ERROR on syncing #{p.display_name}'s profile"
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
      search = Sunspot.new_search(Profile)
      search.build do
        keywords query do
        end
      end
      search.execute
    end
  end
  
end
