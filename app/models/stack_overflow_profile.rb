class StackOverflowProfile
  include Mongoid::Document
  include CodeMav::Taggable
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
  
  def generate_tags
    so_name = 0
    so_count = 1

    return if self.stack_overflow_tags.nil?

    so_tags = YAML.load(self.stack_overflow_tags)
    so_tags.each do |so_tag|
      tag so_tag[so_name], :count => so_tag[so_count]
    end
  end
end
