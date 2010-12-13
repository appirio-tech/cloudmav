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
      current_profile.save
      redirect_to [:my, @blog]
    else
      render :new
    end
  end  
  
  
end