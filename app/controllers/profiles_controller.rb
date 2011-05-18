class ProfilesController < ApplicationController
  before_filter :set_profile, :except => [:index, :search]

  def index
    @profiles = Profile.all
  end

  def search
    @search = params[:search] || ""
    @profiles = Profile.search(@search).results
    render :index
  end
  
  def show
    @tab = "summary"
    @profile_events = ProfileEvent.public.for_profile(@profile).order_by(:date.desc).paginate(:page => 1, :per_page => 10)
  end
  
  def code
    @tab = "code"
    @code_events = ProfileEvent.public.for_profile(@profile).categorized_as("Code").order_by(:date.desc).paginate(:page => 1, :per_page => 10)
    @git_hub_profile = @profile.git_hub_profile
    @stack_overflow_profile = @profile.stack_overflow_profile
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
    @speaker_rate_profile = @profile.speaker_rate_profile
    @slide_share_profile = @profile.slide_share_profile
  end

  def social
    @tab = "social"
    @friends = @profile.followees.sort{|x,y| y.total_score <=> x.total_score }
  end
  
  def edit
    authorize! :edit, @profile
  end
  
  def update
    authorize! :edit, @profile
    if @profile.update_attributes(params[:profile])
      @profile.location = params[:location]
      flash[:notice] = "Profile updated"
      redirect_to @profile
    else
      render :edit
    end
  end
  
  protected
    def set_profile
      @profile = Profile.by_username(params[:username]).first
      unless @profile
        flash[:error] = "Sorry but we couldn't find a profile for #{params[:username]}"
        redirect_to root_path 
      end
    end
end
