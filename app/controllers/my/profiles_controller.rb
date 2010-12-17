class My::ProfilesController < My::MyController
  before_filter :set_profile
  
  def experience
  end
  
  def update
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Profile updated"
      redirect_to @profile
    else
      render "edit"
    end
  end
  
  protected
  
  def set_profile
    @profile = current_profile
  end
end