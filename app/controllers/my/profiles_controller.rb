class My::ProfilesController < My::MyController
  
  def show
    @profile = current_profile
  end
  
  def edit
    @profile = current_profile
  end
  
  def update
    @profile = current_profile
    @profile.update_attributes(params[:profile])
    
    if @profile.save!
      flash[:notice] = "Profile updated"
      redirect_to @profile
    else
      render "edit"
    end
  end
  
end