class CompaniesController < ApplicationController
  
  def show
    @company = Company.find(params[:id])
  end
  
  def index
    @companies = Company.all
  end
  
  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      redirect_to @company
    else
      render :new
    end
  end
  
  def edit
    @company = Company.find(params[:id])
  end
  
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "#{@company.name} updated successfully"
      redirect_to @company
    else
      render :edit
    end  
  end
  
end