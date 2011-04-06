class EventsController < ApplicationController
  before_filter :set_profile

  def index
    query = ProfileEvent.public.for_profile(@profile)
    
    if (params[:filter]) 
      puts "FILTER"
      puts "*****************************"
      query = query.categorized_as(params[:filter]) unless params[:filter] == "All"
    end

    @profile_events = query.order_by(:date.desc)

    respond_to do |wants|
      wants.html {}
      wants.js {}
      wants.json { render :json => @profile_events }
    end
  end

end
