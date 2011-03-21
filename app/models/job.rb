class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  
  field :title, :type => String
  field :description, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :imported_id, :type => String
  field :company_name, :type => String
  
  referenced_in :company, :inverse_of => :employments
  referenced_in :profile, :inverse_of => :jobs

  before_save :set_company_name

  def related_items
    [company, profile.experience_profile]
  end
  
  def set_company_name
    unless company.nil?
      if company_name != company.name
        company_name = company.name
      end
    end
  end
end
