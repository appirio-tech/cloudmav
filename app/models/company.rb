require 'taggable'
require 'indexable'

class Company
  include Mongoid::Document
  include CodeMav::Taggable
  include CodeMav::Indexable
    
  field :name, :type => String
  field :description, :type => String
  mount_uploader :logo, CompanyLogoUploader
  
  references_many :employments, :class_name => "Job", :inverse_of => :company
  
  def calculate_tags
    employments.each do |e|
      e.taggings.each do |tagging|
        self.tag!(tagging.tag.name, :count => tagging.count, :score => tagging.score)
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