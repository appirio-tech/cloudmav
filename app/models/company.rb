class Company
  include Mongoid::Document
    
  field :name, :type => String
  field :description, :type => String
  mount_uploader :logo, CompanyLogoUploader
  
  references_many :employments, :class_name => "Job", :inverse_of => :company
end