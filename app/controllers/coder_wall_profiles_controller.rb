class CoderWallProfilesController < LoggedInController
  
  def new
    authorize! :sync_profile, @profile
    @coder_wall_profile = CoderWallProfile.new
  end
  
  def create
    authorize! :sync_profile, @profile
    @coder_wall_profile = CoderWallProfile.new(params[:coder_wall_profile])
    @coder_wall_profile.profile = @profile
    @coder_wall_profile.sync!
        
    redirect_to profile_code_path(@profile)
  end

  def edit
    authorize! :sync_profile, @profile
    @stack_overflow_profile = @profile.stack_overflow_profile
  end

  def update
    authorize! :sync_profile, @profile
    
    if @profile.stack_overflow_profile.update_attributes(params[:stack_overflow_profile])
      @profile.stack_overflow_profile.resync!
      redirect_to profile_code_path(@profile)
    else
      render :edit
    end
  end
  
  def destroy
    authorize! :sync_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.find(params[:id])
    @stack_overflow_profile.unsync!
    redirect_to profile_code_path(@profile)
  end

end

