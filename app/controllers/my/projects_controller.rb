class My::ProjectsController < My::MyController
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    current_profile.projects << @project
    
    if @project.save
      redirect_to [:my, current_profile]
    else
      render :new
    end
  end
  
end