class BlogsController < ApplicationController
  before_filter :set_profile, :only => [:new, :create]
  
  def show
    @blog = Blog.find(params[:id])
  end
  
  def new
    authorize! :add_blog, @profile
    @blog = Blog.new
    @blog_types = Blog.get_providers
  end
  
  def create
    authorize! :add_blog, @profile
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
    @blog = Blog.find(params[:id])
    @blog_types = Blog.get_providers
  end
  
  def update
    @blog = Blog.find(params[:id])
    @blog.blog_type = params[:blog_type]

    if @blog.update_attributes(params[:blog])
      @blog.sync!
      redirect_to profile_writing_path(@profile)
    else
      render :edit
    end
  end
  
end
