class BetaController < ApplicationController
  before_filter :beta_protection
  layout :false
  KEY = "rookie"
  
  def login
    return if params[:beta_key].blank?
    
    if KEY == params[:beta_key]
      session[:beta_invite_code] = KEY
      redirect_to root_path
    else
      flash[:notice] = "Invalid beta key"
    end 
  end
  
  private
  
  def beta_protection
  end
  
end