class PagesController < ApplicationController
  
  def home
    if current_profile
      redirect_to backlog_path
    end
    @user = User.new
  end
  
  def api_documentation
  end

  def points
  end
  
end