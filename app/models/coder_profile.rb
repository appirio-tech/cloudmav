class CoderProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  
  referenced_in :profile, :inverse_of => :coder_profile

  def related_items
    [profile]
  end

end

