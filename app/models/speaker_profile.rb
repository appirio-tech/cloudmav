class SpeakerProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  
  field :speaker_bio, :type => String

  belongs_to :profile

  def related_items
    [profile]
  end

end
