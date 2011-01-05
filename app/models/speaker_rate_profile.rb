class SpeakerRateProfile
  include Mongoid::Document
  
  field :speaker_rate_id
  field :url
  field :rating
  
  embedded_in :profile, :inverse_of => :speaker_rate_profile
  
  before_save :set_url
  
  def sync!
    speaker = SpeakerRate.get_speaker(speaker_rate_id)
    
    self.rating = speaker["rating"]
    
    speaker["talks"].each do |sr_talk|
      talk = create_talk(sr_talk)
      self.profile.talks << talk
    end
    
    self.profile.save!
    self.save!
  end
  
  def as_json(opts={})
    { 
      :speaker_rate_id => speaker_rate_id,
      :rating => rating,
      :url => url
    }
  end
  
  private
    def set_url
      self.url = "http://speakerrate.com/speakers/#{self.speaker_rate_id}"
    end
    
    def create_talk(sr_talk)
      talk = Talk.new
      talk.title = sr_talk["title"]
      talk.description = sr_talk["info"]["text"]
      talk.slides_url = sr_talk["slides_url"]
      talk.presentations << Presentation.new(:presentation_date => DateTime.parse(sr_talk["when"]))
      return talk
    end
end