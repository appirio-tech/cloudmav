class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  
  field :title, :type => String
  field :description, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :imported_id, :type => String
  
  belongs_to :company, :inverse_of => :employments
  belongs_to :profile

  def related_items
    [company, profile.experience_profile]
  end
  
  def generate_tags
  end

end
