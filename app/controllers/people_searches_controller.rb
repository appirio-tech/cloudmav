class PeopleSearchesController < ApplicationController
  
  def new
  end
  
  def create
    @people = Profile.near_loc(params[:location])
    
    respond_to do |format|
      format.js {}
    end
  end
  
end