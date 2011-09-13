class ProfilesController < ApplicationController
  before_filter :set_profile, :except => [:index, :search]

  def index
    #@profiles = Profile.order_by_score.page(params[:page]).per(10)
  end

  def search
    @search = params[:search] || ""
    #@profiles = Profile.search(@search).results
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
  
  def experience
    @tab = "experience"
    # @linkedin_profile = @profile.linkedin_profile
  end

  def writing
    @tab = "writing"
    # @blog_posts = @profile.posts.page(params[:page]).per(5).order_by(:written_on.desc)
  end
  
  def speaking
    @tab = "speaking"
    @speaker_rate_profile = @profile.speaker_rate_profile
    @slide_share_profile = @profile.slide_share_profile
  end

  def social
    @tab = "social"
    @friends = @profile.followees.sort{|x,y| y.total_score <=> x.total_score }
    # @twitter_profile = @profile.twitter_profile
  end
  
  def edit
    #authorize! :edit, @profile
  end
  
  def update
    # authorize! :edit, @profile
    # if @profile.update_attributes(params[:profile])
    #   @profile.location = params[:location]
    #   flash[:notice] = "Profile updated"
    #   redirect_to @profile
    # else
    #   render :edit
    # end
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
