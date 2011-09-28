class ProfilesController < ApplicationController
  before_filter :set_profile, :except => [:index, :search]

  def index
    @current_page = params[:page]
    @profiles = Profile.order_by_score.page(params[:page]).per(10)
  end

  def search
    @search = params[:search] || ""
    @profiles = Profile.search(@search).results
    render :index
  end
  
  def show
    @tab = "summary"
  end
  
  def code
    @tab = "code"
    @git_hub_profile = @profile.git_hub_profile
    @bitbucket_profile = @profile.bitbucket_profile
    @coder_wall_profile = @profile.coder_wall_profile
  end

  def knowledge
    @tab = "knowledge"    
    @stack_overflow_profile = @profile.stack_overflow_profile
  end

  def social
    @tab = "social"
    @friends = @profile.followees.sort{|x,y| y.total_score <=> x.total_score }
    @twitter_profile = @profile.twitter_profile
  end
  
  def edit
    authorize! :edit, @profile
  end
  
  def update
    authorize! :edit, @profile
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Profile updated"
      redirect_to @profile
    else
      render :edit
    end
  end
  
  protected
    def set_profile
      username = params[:id] || params[:username]
      @profile = Profile.by_username(username).first
      unless @profile
        flash[:error] = "Sorry but we couldn't find a profile for #{params[:username]}"
        redirect_to root_path 
      end
    end
end
