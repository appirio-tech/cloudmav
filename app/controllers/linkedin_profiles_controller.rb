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
    
    @jobs = []
    @positions.each do |p|
      unless current_profile.has_job?(p.title)
        job = Job.new
        job.title = p.title
        job.description = p.summary
        start_year = p.start_year || Time.now.year
        start_month = p.start_month || 1
        job.start_date = DateTime.civil(start_year, start_month, 1)
      
        end_year = p.end_year
        end_month = p.end_month 
        if end_year && end_month
          job.end_date = DateTime.civil(end_year, end_month, 1)
        else
          job.end_date = nil
        end
        current_profile.jobs << job
        @jobs << job
      end
    end
  end
  
end