class SpeakerRateProfile
  include Mongoid::Document
  
  field :speaker_rate_id
  field :url
  field :rating
  
  referenced_in :profile
end