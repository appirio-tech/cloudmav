class JobsController < LoggedInController
  
  def edit
    authorize! :sync_profile, @profile
    
    @job = Job.find(params[:id])    
  end
  
  def update
    authorize! :sync_profile, @profile
    
    @job = Job.find(params[:id])
    @job.tags_text = params[:job][:tags_text]
    if @job.save
      @job.retag!
      Resque.enqueue(CalculateSkillsForProfileJob, @profile.id)
      redirect_to profile_experience_path(@profile)
    else
      render :edit
    end
  end
    
end