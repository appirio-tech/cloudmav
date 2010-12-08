class Guidance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :content, :type => String
  field :partial, :type => String
  field :priority, :type => Integer, :default => 1000
  
  references_many :knowledges, :inverse_of => :knowledge
  
  scope :unlearned_by, lambda { |user| not_in(:title => user.knowledges.map{ |k| k.guidance.title }) } 

  def partial?
    partial
  end
  
  def partial_location
    "guidance/#{self.partial}"
  end
end