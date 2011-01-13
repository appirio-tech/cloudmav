class PostsController < ApplicationController
  before_filter :set_blog
  
  def show
    @post = @blog.find(params[:id])
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @blog.posts << @post
    if @post.save
      @blog.save
      current_profile.save
      redirect_to [:my, @blog]
    else
      render :new
    end
  end
  
  protected
    def set_blog
      @blog = current_profile.blogs.find(params[:blog_id])
    end

end