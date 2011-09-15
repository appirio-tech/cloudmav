class StackOverflowProfilesController < LoggedInController
  
  def new
    authorize! :sync_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.new
  end
  
  def create
    authorize! :sync_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.new(params[:stack_overflow_profile])
    @stack_overflow_profile.profile = @profile
    @stack_overflow_profile.sync!
        
    redirect_to profile_knowledge_path(@profile)
  end

  def edit
    authorize! :sync_profile, @profile
    @stack_overflow_profile = @profile.stack_overflow_profile
  end

  def update
    authorize! :sync_profile, @profile
    
    if @profile.stack_overflow_profile.update_attributes(params[:stack_overflow_profile])
      @profile.stack_overflow_profile.resync!
      redirect_to profile_knowledge_path(@profile)
    else
      render :edit
    end
  end
  
  def destroy
    authorize! :sync_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.find(params[:id])
    @stack_overflow_profile.unsync!
    redirect_to profile_knowledge_path(@profile)
  end

end
