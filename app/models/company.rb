require 'carrierwave/mongoid'

class Company
  include Mongoid::Document
  include CodeMav::Taggable
  include CodeMav::Indexable
    
  field :name, :type => String
  field :description, :type => String
  mount_uploader :logo, CompanyLogoUploader
  
  has_many :employments, :class_name => "Job", :inverse_of => :company

  scope :named, lambda {|name| where(:name => name) }
  
  def related_items
    []
  end
  
  def generate_tags
    self.employments.each do |job|
      job.tags.each do |t| 
        tag t
      end
    end    
  end
  
  def self.search(query, options = {})
    search = Sunspot.new_search(Company)
    search.build do
      keywords query do
      end
    end
    search.execute
  end
end
