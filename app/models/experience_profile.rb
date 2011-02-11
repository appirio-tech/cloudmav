class ExperienceProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable

  referenced_in :profile, :inverse_of => :experience_profile

end
