class PagesController < ApplicationController
  
  def home
    if current_profile
      redirect_to backlog_path
    end
    @events = ProfileEvent.public.order_by(:date.desc).limit(10)
    @profile = Profile.showcase.first

    rss = SimpleRSS.parse open("http://lanyrd.com/topics/net/feed/")
    @summary = rss.items[0].summary.html_safe

  end
  
  def api_documentation
  end
  
end
