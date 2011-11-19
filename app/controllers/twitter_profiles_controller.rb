class TwitterProfilesController < LoggedInController
  
  def new
    authorize! :sync_profile, @profile
    @twitter_profile = TwitterProfile.new
  end
  
  def create
    authorize! :sync_profile, @profile
    @twitter_profile = TwitterProfile.new(params[:twitter_profile])
    @twitter_profile.profile = @profile
    @twitter_profile.sync!
        
    redirect_to edit_profile_path(@profile)
  end

  def edit
    authorize! :sync_profile, @profile
    @twitter_profile = @profile.twitter_profile
  end

  def update
    authorize! :sync_profile, @profile
    
    @twitter_profile = @profile.twitter_profile
    if @twitter_profile.username == params[:twitter_profile][:username]
      @twitter_profile.sync!
    else
      if @twitter_profile.update_attributes(params[:twitter_profile])
        @twitter_profile.resync!
      end
    end
    
    redirect_to edit_profile_path(@profile)
  end

  def destroy
    authorize! :sync_profile, @profile
    @twitter_profile = TwitterProfile.find(params[:id])
    @twitter_profile.unsync!
    redirect_to edit_profile_path(@profile)
  end
end
