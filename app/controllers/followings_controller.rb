class FollowingsController < ApplicationController
  before_filter :set_profile

  def create
    puts "p: #{params.inspect}"
    puts "profile is #{@profile}"
    authorize! :follow, @profile
    current_profile.follow!(@profile)
    puts "FOLLOW!"
    redirect_to @profile
  end

  private

  def set_profile_from_id
    @profile = Profile.by_username(params[:profile_id]).first
  end

end
