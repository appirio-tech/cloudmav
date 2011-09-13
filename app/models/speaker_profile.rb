class SpeakerProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  
  field :speaker_bio, :type => String

  belongs_to :profile

  def related_items
    [profile]
  end
  
  def generate_tags
  end

end
