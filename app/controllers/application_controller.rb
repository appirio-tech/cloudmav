class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  helper :all
  helper_method :current_profile
  
  def current_profile
    current_user.profile
  end
  
  def geocode(location)
    MultiGeocoder.geocode(location)
  end
end
