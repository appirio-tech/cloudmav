class TalksController < ApplicationController
  before_filter :set_profile, :only => [:new, :show, :create, :edit, :update]
  
  def index
    @talks = Talk.paginate(:page => params[:page], :per_page => 10, :order => 'created_on DESC')
  end
  
  def show
    @talk = Talk.find(params[:id])
  end
  
  def new
    authorize! :add_talk, @profile
    
    @talk = Talk.new
  end
  
  def create
    authorize! :add_talk, @profile
    
    @talk = Talk.new(params[:talk])
    @profile.talks << @talk
        
    if @talk.save
      @profile.save
      flash[:notice] = "#{@talk.title} added as one of your talks"
      redirect_to [@profile, @talk]
    else
      render :new
    end
  end
  
  def edit
    @talk = Talk.find(params[:id])
  end
  
  def update
    @talk = Talk.find(params[:id])
    if @talk.update_attributes(params[:talk])
      flash[:notice] = "'#{@talk.title}' saved"
      redirect_to [@profile, @talk]
    else
      flash[:error] = "There was an error when trying to save your talk"
      render :edit
    end
  end
  
end
