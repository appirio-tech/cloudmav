class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_profile
  before_filter :unseen_badges
  
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :document_not_found
  rescue_from BSON::InvalidObjectId, :with => :document_not_found
  rescue_from CanCan::AccessDenied, :with => :access_denied
  rescue_from RSolr::RequestError, :with => :solr_error
  
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
      profile_syncable_path(current_user.profile)
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
  
  def access_denied
    flash[:error] = "Not authorized to perform that action"
    redirect_to root_path
  end
  
  def solr_error
    
  end
  
  def unseen_badges
    return unless current_user
    unseen_badgings = current_profile.badgings.unseen.to_a
    @unseen_badges = unseen_badgings.map(&:badge)
    unseen_badgings.each {|b| b.mark_as_seen }
  end
end
