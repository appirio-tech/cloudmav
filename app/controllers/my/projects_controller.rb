class My::ProjectsController < My::MyController
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.start_date = Date.parse(params[:start_date])
    @project.end_date = Date.parse(params[:end_date])
    current_profile.projects << @project
    
    if @project.save
      @project.set_technologies!(params[:technologies])
      current_profile.calculate_experience
      current_profile.save
      redirect_to [:my, current_profile]
    else
      render :new
    end
  end
  
end