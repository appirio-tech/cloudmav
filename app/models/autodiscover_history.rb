class AutodiscoverHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  embedded_in :profile

end