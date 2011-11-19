class PagesController < ApplicationController
  
  def home
    if current_profile
      puts "redirect to #{profile_path(current_profile)}"
      redirect_to profile_path(current_profile)
      #redirect_to backlog_path
    else 
      @user = User.new
    end
  end
  
  def api_documentation
  end

  def points
  end
  
end