class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :synonyms, :type => Array, :default => []
  index :name, :unique => true
  
  references_many :taggings

  validates_presence_of :name
  validates_uniqueness_of :name

  scope :named, lambda {|name| {:any_in => { :synonyms => [name] } }}

  before_save :add_name_to_synonym 
  
  def self.find_or_create_named(name)
    tag = Tag.named(name).first
    if tag.nil?
      tag = Tag.new(:name => name)
      tag.save!
    end
    return tag
  end
  
  def add_synonym(name)
    self.synonyms ||= []
    self.synonyms << name unless self.synonyms.include? name
  end
  
  def ==(object)
    super || (object.is_a?(Tag) && name == object.name)
  end

  def to_s
    name
  end
  
  def add_name_to_synonym
    add_synonym(self.name)
  end
  
end