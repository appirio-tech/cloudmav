class My::BlogsController < My::MyController
  
  def show
    @blog = current_profile.blogs.find(params[:id])
  end
  
  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.new(params[:blog])
    current_profile.blogs << @blog
    if @blog.save
      @blog.sync!
      current_profile.save
      redirect_to [:my, @blog]
    else
      render :new
    end
  end  
  
  def edit
    @blog = current_profile.blogs.find(params[:id])
  end
  
  def update
    @blog = current_profile.blogs.find(params[:id])
    if @blog.update_attributes(params[:blog])
      @blog.sync!
      current_profile.save
      redirect_to [:my, @blog]
    else
      render :edit
    end
  end
  
end