class ProfilesController < ApplicationController
  before_filter :set_profile
  
  def show
    @tab = "summary"
  end
  
  def code
    @tab = "code"
  end
  
  def experience
    @tab = "experience"
  end

  def writing
    @tab = "writing"
    @blog_posts = @profile.posts.paginate(:page => params[:page], :per_page => 5, :order => 'written_on DESC')
  end
  
  def speaking
    @tab = "speaking"
  end
    
  def update
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Profile updated"
      redirect_to [:my, @profile]
    else
      render "edit"
    end
  end
  
  protected
    def set_profile
      @profile = Profile.by_username(params[:username]).first
    end
end