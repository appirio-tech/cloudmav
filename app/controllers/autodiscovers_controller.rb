class AutodiscoversController < LoggedInController

  def index
    @profile = Profile.where(:username => params[:profile_id]).first
    @count = Autodiscovery.discover!(@profile)
    respond_to do |format|
      format.html # index.html.erb
      format.js 
    end
  end

  def create
    @profile.sync!
    redirect_to @profile
  end

end
