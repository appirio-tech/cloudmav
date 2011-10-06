class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_profile
  
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :document_not_found
  
  def current_profile
    return nil if current_user.nil?
    current_user.profile
  end
  
  # After sign in path is used by devise after user logs in
  def after_sign_in_path_for(user)
    if current_user.profile.autodiscovered?
      profile_url(current_user.profile)
    else
      current_user.profile.make_autodiscovered!
      edit_profile_path(current_user.profile)
    end
  end
  
  private 
  
  def document_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def set_profile
    username = params[:username] || params[:profile_id]
    @profile = Profile.by_username(username).first
  end
end
