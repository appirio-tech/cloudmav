class PeopleSearchesController < ApplicationController
  
  def new
  end
  
  def create
    @search = Profile.search(params[:search], :near => params[:near])
    @people = @search.results
    # @people = Profile.near_loc(params[:location])
    puts "people ; #{@people.inspect}"
    
    respond_to do |format|
      format.js {}
    end
  end
  
end
