class My::ProjectsController < My::MyController
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    puts "params #{params.inspect}"
    set_date(@project, :start_date)
    set_date(@project, :end_date)
    # @project.start_date = set_date_from_param[:start_date]
    # @project.end_date = set_date_from_param[:end_date]
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