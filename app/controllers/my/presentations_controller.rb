class My::PresentationsController < My::MyController
  before_filter :set_talk
  
  def index
    @presentations = current_profile.presentations
  end
  
  def new
    @presentation = Presentation.new
  end
  
  def create
    @presentation = Presentation.new(params[:presentation])
    @talk.presentations << @presentation
        
    if @presentation.save
      @talk.save
      flash[:notice] = "A presentation of #{@talk.title} has been added"
      redirect_to @talk
    else
      render :new
    end
  end
  
  protected
    def set_talk
      @talk = current_profile.talks.find(params[:talk_id])
    end
end