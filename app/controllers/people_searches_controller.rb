class PeopleSearchesController < ApplicationController
  
  def new
  end
  
  def create
    @people = Profile.near_loc(params[:location])
  end
  
end