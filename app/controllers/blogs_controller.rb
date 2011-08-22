class BlogsController < LoggedInController
  
  def show
    @blog = Blog.find(params[:id])
  end
  
  def new
    authorize! :sync_profile, @profile
    @blog = Blog.new
  end
  
  def create
    authorize! :sync_profile, @profile
    @blog = @profile.blogs.build(params[:blog]) 

    if @blog.save
      @blog.sync!
      @profile.save
      redirect_to profile_writing_path(@profile)
    else
      render :new
    end
  end  
  
  def edit
    authorize! :sync_profile, @profile
    @blog = Blog.find(params[:id])
  end
  
  def update
    authorize! :sync_profile, @profile
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      @blog.resync!
      redirect_to profile_writing_path(@profile)
    else
      render :edit
    end
  end

  def destroy
    authorize! :sync_profile, @profile
    @blog = Blog.find(params[:id])
    @blog.unsync!
    redirect_to profile_writing_path(@profile)
  end
  
end
