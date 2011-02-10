class JobAddedEvent < Event

  referenced_in :job, :inverse_of => :events

  def do_work
    job.retag
  end

  def award_badges
    profile.award_badge("Three letter word J-O-B", :description => "For adding a job")
  end

end
