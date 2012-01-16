# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Codemav::Application.initialize!

SlideShare.API_KEY = "IUKyhLLC"
SlideShare.SECRET = "PdZ8enD1"
API::StackOverflow.API_KEY = "ZJZ_DNRrgk6IQYQ0h_Duyg"

LINKEDIN_API_KEY = "WN1h5Rnogem5mKFgntLRecCK9t6OTF9mb5BF9OYq7LT-ipS0hA1VSnnrJvDoxuDx"
LINKEDIN_SECRET_KEY = "_4xBiXI4G-vs4P-7Vpjemx6bqFdhdY9a7dcwkJhMcfgYkNBpYMWcZ8SD813gf1FQ"

# Twitter.configure do |config|
#  config.consumer_key = "EwT5j6Z8F58Zc0dXSuTWtA"
#  config.consumer_secret = "NU9HOdpfnyOQeePYBMOFnIkNzVgkfJU5DptznyRQ5eE"
#  config.oauth_token = "14870761-2E0n5J5uFYY87AsNW4MaMG9CMN0ja08aSzB9qBiSE"
#  config.oauth_token_secret = "XeEcaWUaNDktbclaMSIZ4gXG5dxeIn28r95uoI2MBKw"
# end