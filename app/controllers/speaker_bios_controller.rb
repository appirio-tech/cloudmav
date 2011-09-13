class SpeakerBiosController < LoggedInController
  
  def new
    @speaker_bio = SpeakerBio.new
  end
  
  def create
    @speaker_bio = SpeakerBio.new(params[:speaker_bio])
    @speaker_bio.profile = @profile
    
    if @speaker_bio.save
      flash[:notice] = "Speaker Bio added."
      redirect_to profile_speaking_path(@profile)
    else
      render :new
    end
  end
  
end