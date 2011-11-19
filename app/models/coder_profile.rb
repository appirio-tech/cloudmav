class CoderProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  
  belongs_to :profile

  def related_items
    [profile]
  end
  
  def generate_tags
    return if self.profile.nil?
    import_tags_from(self.profile.git_hub_profile) unless self.profile.git_hub_profile.nil?
  end

end