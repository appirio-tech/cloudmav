class GitHubProfilesController < ApplicationController
  before_filter :set_profile, :only => [:new, :create]
  
  def new
    authorize! :set_git_hub_profile, @profile
    @git_hub_profile = GitHubProfile.new
  end
  
  def create
    authorize! :set_git_hub_profile, @profile
    @git_hub_profile = GitHubProfile.new(params[:git_hub_profile])
    @git_hub_profile.profile = @profile
    @git_hub_profile.synch!
    
    redirect_to profile_code_path(@profile)
  end

end