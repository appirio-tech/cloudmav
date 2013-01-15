# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Codemav::Application.initialize!

SlideShare.API_KEY = "IUKyhLLC"
SlideShare.SECRET = "PdZ8enD1"
API::StackOverflow.API_KEY = "ZJZ_DNRrgk6IQYQ0h_Duyg"

LINKEDIN_API_KEY = ""
LINKEDIN_SECRET_KEY = ""

# Twitter.configure do |config|
#  config.consumer_key = ""
#  config.consumer_secret = ""
#  config.oauth_token = ""
#  config.oauth_token_secret = ""
# end