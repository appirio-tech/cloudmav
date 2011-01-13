class GitHubProfilesController < ApplicationController
  
  def new
    @git_hub_profile = GitHubProfile.new
  end
  
  def create
    @git_hub_profile = GitHubProfile.new(params[:git_hub_profile])
    @git_hub_profile.profile = current_profile
    @git_hub_profile.synch!
    
    redirect_to [:my, current_profile]
  end

end