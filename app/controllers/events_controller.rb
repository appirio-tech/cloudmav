class EventsController < ApplicationController
  before_filter :set_profile

  def index
    @filter = params[:filter] || "All"
    @subfilter = params[:subfilter] || "All"
    @page = params[:page] || 1

    query = ProfileEvent.public.for_profile(@profile)
    query = query.categorized_as(@filter) unless @filter == "All"
    query = query.subcategorized_as(@subfilter) unless @subfilter == "All"

    @profile_events = query.order_by(:date.desc).paginate(:page => @page, :per_page => 10)

    respond_to do |wants|
      wants.html {}
      wants.js {}
      wants.json { render :json => @profile_events }
    end
  end

end
