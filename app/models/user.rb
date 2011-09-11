class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username, :type => String
  field :email, :type => String
  
  scope :users_created_today, lambda { where(:created_at.lte => Time.now.end_of_day.utc, :created_at.gte => Time.now.beginning_of_day.utc) }

  validates_format_of :username, :with => /\A[a-zA-Z0-9]+\z/, :message => "Only letters and numbers allowed"
  
  before_create :add_profile
  before_create :downcase_username

  def downcase_username
    self.username=username.downcase
  end
  
  protected

  def add_profile
    if self.profile.nil?
       self.profile = Profile.new(:email => self.email, :api_id => self.username, :username => self.username)
       self.profile.save
     end
  end
end
