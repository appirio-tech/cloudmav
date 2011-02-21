class SpeakerRateProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  include CodeMav::Synchable
  
  field :speaker_rate_id
  field :url
  field :rating
  
  referenced_in :profile, :inverse_of => :speaker_rate_profile
  
  def as_json(opts={})
    { 
      :speaker_rate_id => speaker_rate_id,
      :rating => rating,
      :url => url
    }
  end
  
end
