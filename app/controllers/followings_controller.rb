class FollowingsController < ApplicationController
  before_filter :set_profile

  def create
    authorize! :follow, @profile
    current_profile.follow!(@profile)
    redirect_to @profile
  end

  private

  def set_profile_from_id
    @profile = Profile.by_username(params[:profile_id]).first
  end

end
