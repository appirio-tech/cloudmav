class Skill
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :tags, :type => Array
  
  def self.create_or_update!(name, tags)
    skill = Skill.where(:name => name).first
    if skill.nil?
      skill = Skill.new(:name => name)
    end    
    skill.tags = tags
    skill.save
  end
end