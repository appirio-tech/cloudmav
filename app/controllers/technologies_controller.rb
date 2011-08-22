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

  def edit
    @technology = Technology.find(params[:id])
  end

  def update
    @technology = Technology.find(params[:id])

    if @technology.update_attributes(params[:technology])
      redirect_to technologies_path
    else
      render :edit
    end
  end

  def destroy
    @technology = Technology.find(params[:id])
    @technology.destroy
    redirect_to technologies_path
  end
end
