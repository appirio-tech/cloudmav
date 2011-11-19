class LinkedinPosition
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :imported_id, :type => String
  field :title, :type => String
  field :description, :type => String
  field :company_id, :type => String
  field :company_name, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  
  embedded_in :linkedin_profile
  
  def date_range
    sd = "No start date"
    if self.start_date
      sd = self.start_date.strftime("%m/%d/%y")
    end
    
    ed = "Present"
    if self.end_date
      ed = self.end_date.strftime("%m/%d/%y")
    end
    
    "#{sd} - #{ed}"    
  end
  
  def set_info_from_linkedin_position(position)
    self.imported_id = position.id
    self.title = position.title
    self.description = position.summary
    unless position.company.nil?
      self.company_id = position.company.id 
      self.company_name = position.company.name
    end
    
    self.start_date = convert_linkedin_date(position.start_date)
    self.end_date = convert_linkedin_date(position.end_date)
  end
  
  def convert_linkedin_date(linkedin_date)
    return nil if linkedin_date.nil?
    year = linkedin_date.year
    return nil if year.nil? || year == 0
    month = linkedin_date.month
    if month.nil? || month == 0
      return DateTime.civil(year, 1, 1)
    else
      return DateTime.civil(year, month, 1)
    end
  end
  
  def set_info_on_job(job)
    job.title = self.title
    job.description = self.description
    job.start_date = self.start_date
    job.end_date = self.end_date
    job.imported_id = self.imported_id
    unless self.company_id.nil?
      job.company = get_company
    end
  end
  
  def get_company
    company = Company.where(:linkedin_id => self.company_id).first
    if company.nil?
      company = Company.new
      company.linkedin_id = self.company_id
      company.name = self.company_name
      company.save
    end
    company    
  end
  
end