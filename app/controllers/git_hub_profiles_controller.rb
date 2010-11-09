class GitHubProfilesController < ApplicationController
  
  def new
    @git_hub_profile = GitHubProfile.new
  end
  
  def create
    @git_hub_profile = GitHubProfile.new(params[:git_hub_profile])
    @git_hub_profile.profile = current_profile
    @git_hub_profile.save!
    
    redirect_to current_profile
  end
  
  def synch
    current_profile.git_hub_profile.synch!
    
    redirect_to current_profile
  end
end