class ProjectsController < ApplicationController
  before_filter :set_profile, :only => [:new, :create]
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    authorize! :add_project, @profile
    
    @project = Project.new
  end
  
  def create
    authorize! :add_project, @profile
    
    @project = Project.new(params[:project])

    set_date(@project, :start_date)
    set_date(@project, :end_date)
    @profile.projects << @project

    if @project.save
      @project.set_technologies!(params[:technologies])
      @profile.calculate_experience
      @profile.save
      redirect_to profile_experience_path(@profile)
    else
      render :new
    end
  end
  
  protected
    def set_profile
      @profile = Profile.by_username(params[:username]).first
    end
end
