class TalksController < ApplicationController
  before_filter :set_profile
  
  def index
    @talks = Talk.for_profile(@profile).order_by([[:created_at, :desc]])
  end
  
  def show
    @talk = Talk.by_permalink(params[:id]).first
  end
  
  def new
    authorize! :add_talk, @profile
    
    @talk = Talk.new
  end
  
  def create
    authorize! :add_talk, @profile
    
    @talk = Talk.new(params[:talk])
    @talk.profile = @profile
        
    if @talk.save
      flash[:notice] = "#{@talk.title} added as one of your talks"
      redirect_to [@profile, @talk]
    else
      render :new
    end
  end
  
  def edit
    @talk = Talk.by_permalink(params[:id]).first
  end
  
  def update
    @talk = Talk.by_permalink(params[:id]).first
    if @talk.update_attributes(params[:talk])
      flash[:notice] = "'#{@talk.title}' saved"
      redirect_to [@profile, @talk]
    else
      flash[:error] = "There was an error when trying to save your talk"
      render :edit
    end
  end
  
end
