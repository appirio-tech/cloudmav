class FollowingsController < ApplicationController
  before_filter :set_profile

  def index
  end

  def create
    authorize! :follow, @profile
    current_profile.follow!(@profile)
    @current_profile = current_profile
    
    respond_to do |wants|
      wants.html {
        puts "HTML"
        redirect_to @profile
      }
      wants.js {
        puts "JS"
      }
      wants.json {
                puts "JSON"
      }
    end
  end

  def destroy
    authorize! :follow, @profile
    current_profile.unfollow!(@profile)

    @current_profile = current_profile

    respond_to do |wants|
      wants.html {
        redirect_to @profile
      }
      wants.js {}
      wants.json {
      }
    end
  end

  private

  def set_profile_from_id
    @profile = Profile.by_username(params[:profile_id]).first
  end

end
