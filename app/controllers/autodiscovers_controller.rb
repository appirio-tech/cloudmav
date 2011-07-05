class AutodiscoversController < LoggedInController

  def index
    @profile = Profile.where(:username => params[:profile_id]).first
    @autodiscover_id = params[:autodiscover_id] || Autodiscovery.get_id
    @count = Autodiscovery.discover!(@autodiscover_id, @profile)
    respond_to do |format|
      format.html {
        if (@count == 0)
          redirect_to profile_path(@profile)
        end
      }
      format.js 
    end
  end

  def create
    @profile.sync!
    redirect_to @profile
  end

end
