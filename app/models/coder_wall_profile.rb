class CoderWallProfile
  include Mongoid::Document
  include CodeMav::Taggable
  include CodeMav::Eventable
  include CodeMav::Syncable
  
  field :username
  field :url, :type => String
  field :badges_count, :type => Integer, :default => 0
  
  referenced_in :profile, :inverse_of => :coder_wall_profile
  embeds_many :badges, :class_name => "CoderWallBadge"
  
  def related_items
    [profile.coder_profile]
  end
  
end

