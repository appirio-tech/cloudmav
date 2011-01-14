require 'taggable'

class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  
  field :title, :type => String
  field :description, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  
  referenced_in :company, :inverse_of => :jobs
  referenced_in :profile, :inverse_of => :jobs
  
  def company_name
    return "" if company.nil?
    company.name
  end
  
  def company_name=(value)
    return if !company.nil? and company.name == value
    
    c = Company.where(:name => value).first
    if c.nil?
      c = Company.new(:name => value)
      c.save
    end
    self.company = c
  end
  
end