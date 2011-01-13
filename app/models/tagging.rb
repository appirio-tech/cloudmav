class Tagging 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :count, :type => Integer
  
  referenced_in :tag, :inverse_of => :taggings
  referenced_in :talk, :inverse_of => :taggings
  
  def to_s
    tag.to_s
  end
end