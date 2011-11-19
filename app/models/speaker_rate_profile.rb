class SpeakerRateProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Syncable
  
  field :speaker_rate_id
  field :url
  field :rating
  
  belongs_to :profile
  
end
