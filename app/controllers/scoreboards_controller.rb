class ScoreboardsController < ApplicationController
  
  def index
    
  end
  
  def stack_overflow
    @profiles = Profile.top_stack_overflow
    if params.key? :near
      @profiles = @profiles.near_loc(params[:near])
    end

    limit = params[:limit].nil? ? 25 :  params[:limit]
    @profiles = @profiles.limit(limit)
  end
  
end