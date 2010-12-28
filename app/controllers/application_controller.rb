class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :beta_protection
  before_filter :get_guidance

  helper :all
  helper_method :current_profile
  
  def current_profile
    current_user.profile
  end
  
  def geocode(location)
    MultiGeocoder.geocode(location)
  end
  
  def beta_protection
    return if Rails.env.test?
    unless session[:beta_invite_code] == BetaController::KEY
      flash[:notice] = "Please enter your beta key"
      redirect_to beta_login_path
      return false
    end
  end
  
  def get_guidance
    return if current_user.nil?
    @guidance = current_profile.get_guidance
  end
  
  private 
  
  def set_date(model, param_name)
    # puts "d : #{params[param_name]}"
    # date = Date.parse(params[param_name])
    date = Date.strptime(params[param_name], '%m/%d/%Y')
    model.send("#{param_name.to_s}=", date)
  end
end
