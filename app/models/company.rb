class Company
  include Mongoid::Document
  require 'paperclip'
  include Paperclip
    
  field :name, :type => String
  
  # has_attached_file :logo,
  #   {
  #     :styles => { :thumb=> "100x100#", :small  => "150x150>" }
  #   }.merge(PAPERCLIP_CONFIG)
    
end