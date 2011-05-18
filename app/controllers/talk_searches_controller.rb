class TalkSearchesController < ApplicationController
  
  def show
    @talks = Talk.paginate(:page => params[:page], :per_page => 10)
  end
  
  def create
    @search = Talk.search(params[:search])
    @talks = @search.results
    respond_to do |format|
      format.js {}
    end
  end
  
end
