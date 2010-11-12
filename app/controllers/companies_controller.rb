class CompaniesController < ApplicationController
  
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
  
  def show
    @company = Company.find(params[:company_id])
  end
  
end