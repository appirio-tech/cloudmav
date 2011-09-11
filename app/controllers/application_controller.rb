class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :document_not_found
  
  def current_profile
    return nil if current_user.nil?
    current_user.profile
  end
  
  private 
  
  def document_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
end
