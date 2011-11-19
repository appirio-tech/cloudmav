class LinkedinRequest
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :request_token, :type => String
  field :request_secret, :type => String
  field :oauth_pin, :type => String
  field :authorization_token, :type => String
  field :authorization_secret, :type => String
  
  embedded_in :linkedin_profile
  
  def create_client!
    client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
    atoken, asecret = client.authorize_from_request(self.request_token, self.request_secret, self.oauth_pin)
    self.authorization_token = atoken
    self.authorization_secret = asecret
    self.save
    client
  end
  
  def set_request_pin!(pin)
    self.oauth_pin = pin
    self.save
  end
end