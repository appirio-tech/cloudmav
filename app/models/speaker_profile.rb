class SpeakerProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  
  belongs_to :profile

  def related_items
    [profile]
  end
  
  def generate_tags
    self.profile.talks.each do |t|
      import_tags_from(t)
    end
  end

end
