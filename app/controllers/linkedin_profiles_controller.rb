require 'linkedin'

class LinkedinProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_profile, :only => [:new, :create, :confirm, :destroy, :callback]

  rescue_from OAuth::Problem, :with => :oauth_error

  def oauth_error(error)
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
    request_token = @client.request_token(:oauth_callback => callback_profile_linkedin_profile_url(@profile, @profile.linkedin_profile))
    @profile.linkedin_profile.create_linkedin_request!(request_token)
    redirect_to @client.request_token.authorize_url
  end

  def callback    
    @linkedin_profile = @profile.linkedin_profile
    @linkedin_profile.linkedin_request.set_request_pin!(params[:oauth_verifier])  
    @linkedin_profile.create_linkedin_positions!
    @profile.calculate_score!
  end
  
  def confirm
    @profile.linkedin_profile.add_positions_from_linkedin!
    redirect_to profile_experience_path(@profile)
  end

  def destroy
    authorize! :sync_profile, @profile
    @linkedin_profile = LinkedinProfile.find(params[:id])
    @linkedin_profile.unsync!
    redirect_to profile_experience_path(@profile)
  end

  private

  def create_client
    @client = LinkedIn::Client.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY)
  end

  def authorize_linked_in_from_callback
    pin = params[:oauth_verifier]
    atoken, asecret = @client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
    session[:atoken] = atoken
    session[:asecret] = asecret    
  end
  
  def authorize_linked_in
    @client.authorize_from_access(session[:atoken], session[:asecret])
  end
end
