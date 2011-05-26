class User
  include Mongoid::Document

  before_create :add_profile       
  before_create :downcase_username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  references_one :profile
  
  field :username, :type => String

  validates_format_of :username, :with => /\A[a-zA-Z0-9]+\z/, :message => "Only letters and numbers allowed"

  def downcase_username
    self.username=username.downcase
  end
  
  protected

  def add_profile
    if self.profile.nil?
       self.profile = Profile.new(:email => self.email, :api_id => self.username, :username => self.username)
     end
  end

end
