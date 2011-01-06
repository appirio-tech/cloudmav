class My::SlideShareProfilesController < My::MyController
  
  def new
    @slide_share_profile = SlideShareProfile.new
  end
  
  def create
    @slide_share_profile = SlideShareProfile.new(params[:slide_share_profile])
    @slide_share_profile.profile = current_profile
    @slide_share_profile.sync!
        
    redirect_to [:my, current_profile]
  end
  
end