class PresentationsController < ApplicationController
  before_filter :set_talk
  
  def index
    @presentations = current_profile.presentations
  end

  def show
    @presentation = Presentation.find(params[:id])
  end
  
  def new
    authorize! :add_presentation, @talk
    
    @presentation = Presentation.new
  end
  
  def create
    authorize! :add_presentation, @talk

    @presentation = Presentation.new(params[:presentation])
    @presentation.presentation_date = get_datetime(params["presentation"]["date_string"], params["presentation"]["time_string"])
    @talk.presentations << @presentation
        
    if @presentation.save
      @talk.save
      flash[:notice] = "A presentation of #{@talk.title} has been added"
      redirect_to @talk
    else
      render :new
    end
  end

  def edit
    @presentation = Presentation.find(params[:id])

    authorize! :edit, @presentation
  end

  def update
    @presentation = Presentation.find(params[:id])

    authorize! :edit, @presentation

    @presentation.presentation_date = get_datetime(params["presentation"]["date_string"], params["presentation"]["time_string"])

    if @presentation.update_attributes(params[:presentation])
      flash[:notice] = "Presentation was updated"
      redirect_to [@talk, @presentation]
    else
      render :edit
    end
  end
  
  protected
    def set_talk
      @talk = Talk.find(params[:talk_id])
    end
end