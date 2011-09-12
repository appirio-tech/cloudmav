class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Gravtastic
  include Badgeable::Subject
  include CodeMav::Autodiscoverable
  include CodeMav::Locatable
  include CodeMav::Scorable  
  include CodeMav::CoderModule
  include CodeMav::Taggable
  
  gravtastic
  
  field :name, :type => String
  field :email, :type => String
  field :username, :type => String
  
  index :username, :unique => true
  
  belongs_to :user
  
  scope :by_username, lambda { |uname| where(:username => uname) }
  scope :named, lambda { |name| { :where => { :name => name } } }
  
  def display_name
    (self.name.blank? || self.name.nil?) ? self.username : self.name
  end
  
  def to_param
    username
  end
  
  def total_score
    0
  end
  
  def calculate_score!
    Resque.enqueue(CalculateScoreForProfileJob, self.id)
  end
  
  def related_items
    []
  end
  
  def generate_tags
    import_tags_from(self.coder_profile)
  end
  
  def remove_badge(badge_name)
    badge = Badge.where(:name => badge_name).first
    unless badge.nil?
      badging = self.badgings.where(:badge_id => badge.id).first
      badging.destroy unless badging.nil?
    end
  end
  
end