class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :beta_protection
  
  helper :all
  helper_method :current_profile
  
  def current_profile
    current_user.profile
  end
  
  def geocode(location)
    MultiGeocoder.geocode(location)
  end
  
  def beta_protection
    unless session[:beta_invite_code] == BetaController::KEY
      flash[:notice] = "Please enter your beta key"
      redirect_to beta_login_path
      return false
    end
  end
end
