class JobsController < ApplicationController
  before_filter :set_profile
  
  def new
    authorize! :manage_jobs, @profile
    @job = Job.new
  end
  
  def create
    authorize! :manage_jobs, @profile
    @job = Job.new(params[:job])
    @job.profile = @profile
    if @job.save
      flash[:notice] = "'#{@job.title}' job has been added"
      redirect_to profile_experience_path(@profile)
    else
      render :new
    end
  end
  
end