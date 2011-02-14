class SpeakerRateProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  
  field :speaker_rate_id
  field :url
  field :rating
  
  referenced_in :profile, :inverse_of => :speaker_rate_profile
  
  before_save :set_url
  
  def synch!
    speaker = SpeakerRate.get_speaker(speaker_rate_id)
    
    self.rating = speaker["rating"]
    
    speaker["talks"].each {|t| create_talk(t) unless already_has_talk?(t) }
    
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
    
    def already_has_talk?(sr_talk)
      self.profile.talks.where(:imported_id => sr_talk["id"]).first
    end
    
    def create_talk(sr_talk)
      talk = Talk.new
      talk.title = sr_talk["title"]
      talk.description = sr_talk["info"]["text"]
      talk.slides_url = sr_talk["slides_url"]
      talk.imported_id = sr_talk["id"]
      self.profile.talks << talk
      talk.save
      
      Presentation.create(:presentation_date => DateTime.parse(sr_talk["when"], :talk => talk))
    end
end
