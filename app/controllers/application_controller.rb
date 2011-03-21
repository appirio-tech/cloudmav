class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_guidance
  before_filter :unseen_badges

  helper :all
  helper_method :current_profile
  
  rescue_from CanCan::AccessDenied, :with => :access_denied
  
  def current_profile
    return nil if current_user.nil?
    current_user.profile
  end
  
  def geocode(location)
    MultiGeocoder.geocode(location)
  end
  
  def get_guidance
    return if current_user.nil?
    @guidance = current_profile.get_guidance
  end

  def after_sign_in_path_for(user)
    profile_path(user.profile)
  end
  
  private 
    def set_profile
      username = params[:username] || params[:profile_id]
      @profile = Profile.by_username(username).first
    end
    
    def set_date(model, param_name)
      date = Date.strptime(params[param_name], '%m/%d/%Y')
      model.send("#{param_name.to_s}=", date)
    end
    
    def access_denied
      flash[:error] = "Not authorized to perform that action"
      redirect_to root_path
    end
    
    def unseen_badges
      return unless current_user
      unseen_badgings = current_profile.badgings.unseen.to_a
      @unseen_badges = unseen_badgings.map(&:badge)
      unseen_badgings.each {|b| b.mark_as_seen }
    end
end
