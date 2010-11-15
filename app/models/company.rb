class Company
  include Mongoid::Document
    
  field :name, :type => String
  
  mount_uploader :logo, CompanyLogoUploader
      
end