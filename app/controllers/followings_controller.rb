class FollowingsController < ApplicationController
  before_filter :set_profile

  def index

  end

  def create
    authorize! :follow, @profile
    current_profile.follow!(@profile)
    redirect_to @profile
  end

  def destroy
    authorize! :follow, @profile
    current_profile.unfollow!(@profile)
    redirect_to @profile
  end

  private

  def set_profile_from_id
    @profile = Profile.by_username(params[:profile_id]).first
  end

end
