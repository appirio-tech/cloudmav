class RecalculateScoreEvent < Event
  referenced_in :profile, :inverse_of => :events, :index => true

  def do_work
    ProfileEvent.for_profile(profile).to_a.each do |e|
      e.score_points if e.respond_to? :score_points
    end

    SyncEvent.for_profile(profile).to_a.each do |e|
      e.earn_points if e.respond_to? :earn_points
    end

    profile.save
  end

end
