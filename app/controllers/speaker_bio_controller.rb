class SpeakerBioController < ApplicationController
  before_filter :set_profile
  
  def edit
    authorize! :set_speaker_bio, @profile
  end
  
  def update
    authorize! :set_speaker_bio, @profile
    @profile.set_speaker_bio params[:speaker_bio]
    if @profile.save
      flash[:notice] = "Speaker bio was updated"
      redirect_to profile_speaking_path(@profile)
    else
      render :new
    end
  end
end