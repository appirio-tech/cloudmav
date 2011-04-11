class JobEvent < ProfileEvent

  referenced_in :job, :inverse_of => :events

  def set_info
    self.category = "Experience"
    self.is_public = true
  end

  def other_work
    set_company

    job.turn_off_events
    job.save
    job.turn_on_events

    job.retag!
  end

  def set_company
    return if !job.company.nil? and job.company.name == job.company_name
    
    c = Company.where(:name => job.company_name).first

    if c.nil?
      c = Company.create(:name => job.company_name)
    end

    job.company = c
    job.company_name = c.name
  end

  def icon_url
    "event_icons/experience.png"
  end
 
end
