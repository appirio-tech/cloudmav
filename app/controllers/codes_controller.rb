class CodesController < ApplicationController
  before_filter :set_profile
  
  def show
    @tab = "code"
    
    @git_hub_profile = @profile.git_hub_profile
    @git_hub_repositories = []
    if @git_hub_profile
      @git_hub_repositories = @git_hub_profile.repositories.order_by_score.page(params[:page]).per(5)
    end
    
    @bitbucket_profile = @profile.bitbucket_profile
    @bitbucket_repositories = []
    if @bitbucket_profile
      @bitbucket_repositories = @bitbucket_profile.repositories.page(params[:page]).per(5)
    end
    
    @coder_wall_profile = @profile.coder_wall_profile
  end
  
  def edit
    @tab = "code"
    @git_hub_profile = @profile.git_hub_profile
    @bitbucket_profile = @profile.bitbucket_profile
    @coder_wall_profile = @profile.coder_wall_profile
  end
  
end