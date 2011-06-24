class AutodiscoverEvent < Event
  referenced_in :profile, :inverse_of => :events, :index => true
  field :discover_type, :type => String

end

