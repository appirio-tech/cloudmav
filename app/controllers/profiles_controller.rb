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
    # @skill_pie_javascript_data = SkillsPiePresenter.get_javascript_data(@profile)
    # @dev_journey_data = DevJourneyPresenter.get_data(@profile)
    # @dev_journey_jobs_data = DevJourneyJobsPresenter.get_data(@profile)
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
      rescue BSON::InvalidStringEncoding
        document_not_found
    end
end
