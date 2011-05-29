require 'linkedin'

class LinkedinProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_profile, :only => [:new, :create, :confirm]

  rescue_from OAuth::Problem, :with => :oauth_error

  def oauth_error
    flash[:error] = "There was a problem with your authentication with LinkedIn. Give it another shot."
    redirect_to profile_experience_path(current_profile)
  end

  def new
    if @profile.linkedin_profile.nil?
      @profile.linkedin_profile = LinkedinProfile.new
      @profile.linkedin_profile.save
      @profile.save
    end
    create_client
    request_token = @client.request_token(:oauth_callback => callback_profile_linkedin_profiles_url)
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    session[:profile_id] = @profile.id
    redirect_to @client.request_token.authorize_url
  end

  def callback
    create_client
    authorize_linked_in
    @profile = Profile.find(session[:profile_id])
    @jobs = @profile.linkedin_profile.get_jobs(@client)
  end
  
  def confirm
    create_client
    authorize_linked_in
    @profile.linkedin_profile.sync_jobs!(@client)
    redirect_to profile_experience_path(@profile)
  end

  private

  def create_client
    @client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
  end

  def authorize_linked_in
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = @client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      @client.authorize_from_access(session[:atoken], session[:asecret])
    end
  end
end
