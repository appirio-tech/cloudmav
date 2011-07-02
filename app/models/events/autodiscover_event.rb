class AutodiscoverEvent < Event
  referenced_in :profile, :inverse_of => :events, :index => true
  field :discover_type, :type => String
  field :autodiscover_id, :type => String

  def do_work
    profile.autodiscover_histories.create(:name => discover_type)
    discover
  end
end

