class JobsController < ApplicationController
  before_filter :set_profile, :only => [:new, :create]
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
  
  def edit
    @job = Job.find(params[:id])   
    @profile = @job.profile
    authorize! :manage_jobs, @profile
  end
  
  def update
    @job = Job.find(params[:id])
    @profile = @job.profile
    authorize! :manage_jobs, @profile

    if @job.update_attributes(params[:job])
      flash[:notice] = "'#{@job.title}' job has been saved"
      redirect_to profile_experience_path(@profile)
    else
      render :new
    end    
  end
  
end