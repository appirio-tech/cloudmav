class JobAddedEvent < JobEvent

  def award_badges
    profile.award_badge("Three letter word J-O-B", :description => "For adding a job")
  end

end
