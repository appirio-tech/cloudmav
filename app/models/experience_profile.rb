class ExperienceProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable

  belongs_to :profile

end
