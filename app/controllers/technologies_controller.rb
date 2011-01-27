class TechnologiesController < ApplicationController

  def show
    @technology = Technology.find(params[:id])
  end

  def index
    @technologies = Technology.all
  end

  def new
    @technology = Technology.new
  end

  def create
    @technology = Technology.new(params[:technology])
    if @technology.save
      flash[:notice] = "#{@technology.name} added"
      redirect_to @technology
    else
      render :new
    end
  end

end
