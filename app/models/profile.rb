##### WARNING: THESE ARE MONKEYPATCHES #####
# They are required because the Badgeable gem played fast and loose with
# Ruby meta programming, mixing and matching ActiveRecord and Mongoid in an
# effort to reduce code duplication (and I guess to seem clever).
#
# All I did is to unravel the metaprogramming and hardcode whatever it would
# have resulted in

module Badgeable
  module Adapters
   def self.connect(klass)
      Badgeable::Adapters.current_adapter = :mongoid
      raise ArgumentError, "Badgeable needs a database adapter to work. Add one of the following to your Gemfile: #{Badgeable::Adapters.supported_adapters.map {|name| 'badgeable_' + name.to_s }}" unless Badgeable::Adapters.current_adapter && (Badgeable::Adapters.supported_adapters.include? Badgeable::Adapters.current_adapter)
      klass.send(:include, "Badgeable::Adapters::#{current_adapter.to_s.camelize}Adapter".constantize)
    end
  end
end

class Badging
  include Mongoid::Document
  scope :unseen, {:where => {:seen => false}}

  def mark_as_seen
    update_attributes(:seen => true)
  end
end

class Badge
  include Mongoid::Document
  def self.find_or_create_by_name(name)
    Badge.where(:name => name).first || create(:name => name)
  end

  def icon
    "/images/#{name.parameterize}.jpg"
  end
end

require 'badgeable/adapters/mongoid_adapter'

##### END MONKEYPATCHES #####

class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Gravtastic
  include Badgeable::Subject
  include CodeMav::Autodiscoverable
  include CodeMav::Locatable
  include CodeMav::Scorable
  include CodeMav::Skillable
  include CodeMav::CoderModule
  include CodeMav::KnowledgeModule
  include CodeMav::SpeakerModule
  include CodeMav::Taggable
  include CodeMav::Followable
  include CodeMav::WriterModule
  include CodeMav::ExperienceModule
  include CodeMav::SocialModule

  gravtastic

  field :name, :type => String
  field :email, :type => String
  field :username, :type => String
  field :is_moderator, :type => Boolean, :default => false
  field :is_admin, :type => Boolean, :default => false
  field :last_synced_date, :type => DateTime

  index :username, :unique => true

  attr_protected :is_moderator, :is_admin

  belongs_to :user

  scope :by_username, lambda { |uname| where(:username => uname) }
  scope :named, lambda { |name| { :where => { :name => name } } }

  def display_name
    (self.name.blank? || self.name.nil?) ? self.username : self.name
  end

  def to_param
    username
  end

  def calculate_score!
    Resque.enqueue(CalculateScoreForProfileJob, self.id)
  end

  def calculate_skills!
    Resque.enqueue(CalculateSkillsForProfileJob, self.id)
  end

  def related_items
    []
  end

  def generate_tags
    import_tags_from(self.knowledge_profile) unless self.knowledge_profile.nil?
    import_tags_from(self.coder_profile) unless self.coder_profile.nil?
    import_tags_from(self.speaker_profile) unless self.speaker_profile.nil?
    import_tags_from(self.experience_profile) unless self.experience_profile.nil?
    import_tags_from(self.writer_profile) unless self.writer_profile.nil?
  end

  def remove_badge(badge_name)
    badge = Badge.where(:name => badge_name).first
    unless badge.nil?
      badging = self.badgings.where(:badge_id => badge.id).first
      badging.destroy unless badging.nil?
    end
  end

  def moderator?
    is_moderator
  end

  def admin?
    is_admin
  end

  def sync!
    stack_overflow_profile.sync! unless stack_overflow_profile.nil?
    git_hub_profile.sync! unless git_hub_profile.nil?
    bitbucket_profile.sync! unless bitbucket_profile.nil?
    coder_wall_profile.sync! unless coder_wall_profile.nil?
    speaker_rate_profile.sync! unless speaker_rate_profile.nil?
    slide_share_profile.sync! unless slide_share_profile.nil?
    twitter_profile.sync! unless twitter_profile.nil?
  end

  def display_last_synced_date
    return DateTime.now.strftime("%b %e / %l:%M %p ") if self.last_synced_date.nil?

    last_synced_date.strftime("%b %e / %l:%M %p ")
  end

  class << self
    def sync_all!
      profiles_to_sync = Profile.all.to_a
      profiles_to_sync.each do |p|
        p.sync!
      end
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