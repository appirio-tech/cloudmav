class My::TalksController < My::MyController
  
  def index
    @talks = current_profile.talks
  end
  
  def show
    @talk = current_profile.talks.find(params[:id])
  end
  
  def new
    @talk = Talk.new
  end
  
  def create
    @talk = Talk.new(params[:talk])
    current_profile.talks << @talk
        
    if @talk.save
      current_profile.save
      flash[:notice] = "#{@talk.title} added as one of your talks"
      redirect_to my_talks_path
    else
      render :new
    end
  end
  
end