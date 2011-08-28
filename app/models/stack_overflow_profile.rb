class StackOverflowProfile
  include Mongoid::Document
  include CodeMav::Taggable
  include CodeMav::Eventable
  include CodeMav::Syncable
  
  field :stack_overflow_id
  field :reputation, :type => Integer, :default => 0
  field :url, :type => String
  field :badge_html
  field :stack_overflow_tags
  
  belongs_to :profile
  embeds_many :questions, :class_name => "StackOverflowQuestion"
  embeds_many :answers, :class_name => "StackOverflowAnswer"
  
  def related_items
    [profile.knowledge_profile]
  end
  
  def as_json(opts={})
    { 
      :stack_overflow_id => stack_overflow_id,
      :reputation => reputation,
      :url => url,
      :badge_html => badge_html
    }
  end
end
