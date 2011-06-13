class GitHubProfilesController < LoggedInController
  
  def new
    authorize! :set_git_hub_profile, @profile
    @git_hub_profile = GitHubProfile.new
  end
  
  def create
    authorize! :set_git_hub_profile, @profile
    @git_hub_profile = GitHubProfile.new(params[:git_hub_profile])
    @git_hub_profile.profile = @profile
    @git_hub_profile.sync!
    
    redirect_to profile_code_path(@profile)
  end

  def edit
    authorize! :sync_profile, @profile
    @git_hub_profile = GitHubProfile.find(params[:id])
  end

  def update
    authorize! :sync_profile, @profile
    @git_hub_profile = GitHubProfile.find(params[:id])
    if @git_hub_profile.update_attributes(params[:git_hub_profile])
      @git_hub_profile.resync!
      redirect_to profile_code_path(@profile)
    else
      render :edit
    end
  end

  def destroy
    authorize! :sync_profile, @profile
    @git_hub_profile = GitHubProfile.find(params[:id])
    @git_hub_profile.unsync!
    redirect_to profile_code_path(@profile)
  end

end
