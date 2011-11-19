class KnowledgeProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  
  belongs_to :profile

  def related_items
    [profile]
  end
  
  def generate_tags
    import_tags_from(self.profile.stack_overflow_profile) unless self.profile.stack_overflow_profile.nil?
  end

end