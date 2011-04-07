class TwitterProfilesController < ApplicationController
  before_filter :set_profile
  
  def new
    authorize! :set_twitter_profile, @profile
    @twitter_profile = TwitterProfile.new
  end
  
  def create
    authorize! :set_twitter_profile, @profile
    @twitter_profile = TwitterProfile.new(params[:twitter_profile])
    @twitter_profile.profile = @profile
    @twitter_profile.synch!
        
    redirect_to profile_social_path(@profile)
  end

  def edit
    authorize! :set_twitter_profile, @profile
    @twitter_profile = @profile.twitter_profile
  end

  def update
    authorize! :set_twitter_profile, @profile
    
    if @profile.twitter_profile.update_attributes(params[:twitter_profile])
      @profile.twitter_profile.synch!
      redirect_to profile_social_path(@profile)
    else
      render :edit
    end
  end

end
