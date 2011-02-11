class Company
  include Mongoid::Document
  include CodeMav::Taggable
  include CodeMav::Eventable
  include CodeMav::Indexable
    
  field :name, :type => String
  field :description, :type => String
  mount_uploader :logo, CompanyLogoUploader
  
  references_many :employments, :class_name => "Job", :inverse_of => :company

  scope :named, lambda {|name| where(:name => name) }
  
  def self.search(query, options = {})
    search = Sunspot.new_search(Company)
    search.build do
      keywords query do
      end
    end
    search.execute
  end
end
