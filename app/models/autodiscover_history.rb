class AutodiscoverHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  embedded_in :profile, :inverse_of => :autodiscovery_histories

end
