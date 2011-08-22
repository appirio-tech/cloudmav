class SpeakerProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  
  field :speaker_bio, :type => String

  referenced_in :profile, :inverse_of => :speaker_profile

  def related_items
    [profile]
  end

end
