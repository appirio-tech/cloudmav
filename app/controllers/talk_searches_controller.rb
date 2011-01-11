class TalkSearchesController < ApplicationController
  
  def new
  end
  
  def create
    @search = Talk.search(params[:search])
    @talks = @search.results
    respond_to do |format|
      format.js {}
    end
  end
  
end