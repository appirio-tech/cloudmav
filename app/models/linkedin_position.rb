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
  
  def set_info_from_linkedin_position(position)
    self.imported_id = position.id
    self.title = position.title
    self.description = position.summary
    unless position.company.nil?
      self.company_id = position.company.id 
      self.company_name = position.company.name
    end
    start_year = position.start_year || Time.now.year
    start_month = position.start_month || 1

    if date_valid?(start_year, start_month)
      self.start_date = DateTime.civil(start_year, start_month, 1)
    end
    
    end_year = position.end_year
    end_month = position.end_month 
    if date_valid?(end_year, end_month) 
      self.end_date = DateTime.civil(end_year, end_month, 1)
    else
      self.end_date = nil
    end
  end
  
  def date_valid?(year, month)
    return false unless year && month
    return false if year == 0 || month == 0
    true
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