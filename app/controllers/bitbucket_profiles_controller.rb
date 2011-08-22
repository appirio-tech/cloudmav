class BitbucketProfilesController < LoggedInController

  def new
    authorize! :sync_profile, @profile
    @bitbucket_profile = BitbucketProfile.new
  end
  
  def create
    authorize! :sync_profile, @profile
    @bitbucket_profile = BitbucketProfile.new(params[:bitbucket_profile])
    @bitbucket_profile.profile = @profile
    @bitbucket_profile.sync!
    
    redirect_to profile_code_path(@profile)
  end

  def edit
    authorize! :sync_profile, @profile
    @bitbucket_profile = BitbucketProfile.find(params[:id])
  end

  def update
    authorize! :sync_profile, @profile
    @bitbucket_profile = BitbucketProfile.find(params[:id])
    if @bitbucket_profile.update_attributes(params[:bitbucket_profile])
      @bitbucket_profile.resync!
      redirect_to profile_code_path(@profile)
    else
      render :edit
    end
  end

  def destroy
    authorize! :sync_profile, @profile
    @bitbucket_profile = BitbucketProfile.find(params[:id])
    @bitbucket_profile.unsync!
    redirect_to profile_code_path(@profile)
  end

end
