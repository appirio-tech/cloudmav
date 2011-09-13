class SpeakerBio
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :bio, :type => String
  
  belongs_to :profile
  
end