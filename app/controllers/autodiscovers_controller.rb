class AutodiscoversController < LoggedInController

  def show
    respond_to do |format|
      format.js 
    end
  end
  
  def new
    Resque.enqueue(AutodiscoverJob, @profile.id)
  end
  
  def create
    redirect_to @profile
  end

end
