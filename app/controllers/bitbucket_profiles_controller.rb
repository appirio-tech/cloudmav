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

end
