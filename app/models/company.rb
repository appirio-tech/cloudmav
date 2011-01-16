require 'taggable'

class Company
  include Mongoid::Document
  include CodeMav::Taggable
  
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
end