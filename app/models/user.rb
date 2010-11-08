class User
  include Mongoid::Document

  before_create :add_profile       

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  references_one :profile
  
  protected
  def add_profile
    if self.profile.nil?
       self.profile = Profile.new 
     end
  end
end
