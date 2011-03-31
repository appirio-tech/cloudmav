class PagesController < ApplicationController
  
  def home
    @events = ProfileEvent.public.order_by(:date.desc).limit(10)
    @profile = Profile.showcase.first
  end
  
  def api_documentation
  end
  
end
