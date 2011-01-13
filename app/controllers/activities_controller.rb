class ActivitiesController < ApplicationController
  
  def index
    @activities = Activity.desc(:created_on).limit(10)
  end
  
end