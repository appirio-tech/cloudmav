require 'linkedin'

class LinkedinProfilesController < ApplicationController

  def new
    @linkedin_profile = LinkedinProfile.new
  end
  
  def create
    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
    puts callback_linkedin_profiles_url
    request_token = client.request_token(:oauth_callback => callback_linkedin_profiles_url)
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to client.request_token.authorize_url
  end

  def callback
    client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile = client.profile
    @connections = client.connections
    @positions = client.profile(:fields => %w(positions)).positions
  end
  
end