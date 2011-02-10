class JobUpdatedEvent < ProfileEvent

  referenced_in :job, :inverse_of => :events

  def other_work
    job.retag!
  end

end
