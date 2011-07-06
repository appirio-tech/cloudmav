class CoderWallBadge 
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :coder_wall_profile, :inverse_of => :badges

  field :name, :type => String
  field :badge, :type => String
  field :description, :type => String

  def profile
    coder_wall_profile.profile
  end

end

