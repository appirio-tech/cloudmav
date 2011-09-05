class LinkToSpeakerRatesController < LoggedInController
  before_filter :set_talk

  def new
    authorize! :sync_profile, @profile
    @speaker_rate_talks = Talk.for_profile(@profile).from_speaker_rate
  end

  def create
    authorize! :sync_profile, @profile
    @speaker_rate_talk = Talk.find(params[:speaker_rate_talk][:talk_id])
    @talk.copy_speaker_rate_info_from(@speaker_rate_talk)
    @talk.save
    TalkEvent.for_talk(@speaker_rate_talk).destroy_all
    @speaker_rate_talk.destroy
    redirect_to [@profile, @talk]
  end

  def refresh
    authorize! :sync_profile, @profile

    event = SpeakerRateProfileSyncEvent.new(:speaker_rate_profile => @profile.speaker_rate_profile, :profile => @profile)
    event.sync
    redirect_to new_profile_talk_link_to_speaker_rate_path(@profile, @talk)
  end

  private

  def set_talk
    @talk = Talk.by_permalink(params[:talk_id]).first
  end

end
