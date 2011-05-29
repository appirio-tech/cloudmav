class BlogsController < ApplicationController
  before_filter :set_profile, :only => [:new, :create, :edit, :update]
  
  def show
    @blog = Blog.find(params[:id])
  end
  
  def new
    authorize! :add_blog, @profile
    @blog = Blog.new
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
    authorize! :add_blog, @profile
    @blog = Blog.find(params[:id])
  end
  
  def update
    authorize! :add_blog, @profile
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      @blog.sync!
      redirect_to profile_writing_path(@profile)
    else
      render :edit
    end
  end
  
end
