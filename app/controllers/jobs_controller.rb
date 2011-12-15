class JobsController < LoggedInController
  
  def edit
    authorize! :sync_profile, @profile
    
    @job = Job.find(params[:id])    
  end
  
  def update
    authorize! :sync_profile, @profile
    
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      @job.retag!
      Resque.enqueue(CalculateScoreForProfileJob, @profile.id)
      redirect_to profile_experience_path(@profile)
    else
      render :edit
    end
  end
    
end