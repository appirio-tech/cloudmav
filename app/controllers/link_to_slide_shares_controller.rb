class LinkToSlideSharesController < LoggedInController
 before_filter :set_talk

  def new
    authorize! :sync_profile, @profile
    @slide_share_talks = Talk.for_profile(@profile).from_slide_share
  end

  def create
    authorize! :sync_profile, @profile
    @slide_share_talk = Talk.find(params[:slide_share_talk][:talk_id])
    @talk.copy_slide_share_info_from(@slide_share_talk)
    @talk.save
    @slide_share_talk.destroy
    redirect_to [@profile, @talk]
  end

  def refresh
    authorize! :sync_profile, @profile
    
    SyncSlideShareProfileJob.perform(@profile.slide_share_profile.id)
    redirect_to new_profile_talk_link_to_slide_share_path(@profile, @talk)
  end

  private

  def set_talk
    @talk = Talk.by_permalink(params[:talk_id]).first
  end

end
