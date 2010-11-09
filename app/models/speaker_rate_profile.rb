class SpeakerRateProfile
  include Mongoid::Document
  
  field :speaker_rate_id
  field :url
  field :rating
  
  referenced_in :profile
  
  def as_json(opts={})
    { 
      :speaker_rate_id => speaker_rate_id,
      :rating => rating,
      :url => url
    }
  end
end