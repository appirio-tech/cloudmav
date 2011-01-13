class ActivitiesController < ApplicationController
  
  def index
    @activities = Activity.desc(:created_at).limit(10)
  end
  
end