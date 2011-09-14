class ExperienceProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable

  belongs_to :profile

  def related_items
    [profile]
  end
  
  def generate_tags
    self.profile.jobs.each do |j|
      import_tags_from(j)
    end
  end
end
