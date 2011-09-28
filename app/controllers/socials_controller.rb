class SocialsController < ApplicationController
  before_filter :set_profile
  
  def show
    @tab = "social"
    @friends = @profile.followees.sort{|x,y| y.total_score <=> x.total_score }
    @twitter_profile = @profile.twitter_profile
  end
  
  def edit
    @tab = "social"
    @twitter_profile = @profile.twitter_profile
  end
  
end