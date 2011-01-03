class PostsController < ApplicationController
  before_filter :set_blog
  
  def show
    @post = @blog.find(params[:id])
  end
  
  protected
    def set_blog
      @blog = current_profile.blogs.find(params[:blog_id])
    end
  
end