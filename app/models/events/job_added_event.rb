class JobAddedEvent < JobEvent

  def award_badges
    profile.award_badge("Three letter word J-O-B", :description => "For adding a job")
  end

  def description
    "Added #{job.title} job with #{job.company_name}"
  end

end
