class My::BlogsController < My::MyController
  
  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.new(params[:blog])
    current_profile.blogs << @blog
    if @blog.save
      current_profile.save
      redirect_to current_profile
    else
      render :new
    end
  end  
  
  
end