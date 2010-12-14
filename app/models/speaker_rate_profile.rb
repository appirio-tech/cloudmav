class SpeakerRateProfile
  include Mongoid::Document
  
  field :speaker_rate_id
  field :url
  field :rating
  
  embedded_in :profile, :inverse_of => :speaker_rate_profile
  
  def sync!
    SpeakerRateService.sync(self)
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
end