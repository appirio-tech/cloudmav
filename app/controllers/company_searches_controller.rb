class CompanySearchesController < ApplicationController
  
  def new
  end
  
  def create
    @search = params[:search]
    @search_results = Company.search(params[:search])
    @companies = @search_results.results
    puts "@c #{@companies.inspect}"
    respond_to do |format|
      format.html { render :new }
      format.js {}
    end
  end
  
end