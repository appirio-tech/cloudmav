class PagesController < ApplicationController
  
  def home    
    if current_profile
      flash.keep
      redirect_to profile_path(current_profile)
    else 
      @user = User.new
    end
  end
  
  def api_documentation
  end

  def points
  end

  def change_log
  end
  
end