class PresentationsController < ApplicationController
  before_filter :set_talk
  
  def index
    @presentations = current_profile.presentations
  end
  
  def new
    @presentation = Presentation.new
  end
  
  def create
    authorize! :add_presentation, @talk

    @presentation = Presentation.new(params[:presentation])
    @presentation.presentation_date = get_datetime(params["presentation_date"], params["presentation_time"])
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
