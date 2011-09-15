class TalkSearchesController < ApplicationController
  
  def show
    @talks = Talk.page(params[:page]).per(10)
  end
  
  def create
    @search = Talk.search(params[:search])
    @talks = @search.results
    render :show
  end
  
end