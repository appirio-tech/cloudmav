class User
  include Mongoid::Document

  before_create :add_profile       

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  references_one :profile
  
  field :username, :type => String
  
  protected

  def add_profile
    if self.profile.nil?
       self.profile = Profile.new(:email => self.email, :api_id => self.username, :username => self.username)
     end
  end

end
