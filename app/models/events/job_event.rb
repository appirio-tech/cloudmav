class JobEvent < ProfileEvent

  referenced_in :job, :inverse_of => :events

  def other_work
    set_company
    job.retag!

    Job.skip_callback(:update, :after, :create_updated_event)
    job.save
    Job.set_callback(:update, :after, :create_updated_event)
  end

  def set_company
    return if !job.company.nil? and job.company.name == job.company_name
    
    c = Company.where(:name => job.company_name).first
    c = Company.create(:name => job.company_name) if c.nil?

    job.company = c
    job.company_name = c.name
  end
 
end
