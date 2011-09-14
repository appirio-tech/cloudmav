class AutodiscoversController < LoggedInController

  def new
    Resque.enqueue(AutodiscoverJob, @profile.id)
  end
  
  def create
    redirect_to @profile
  end

end
