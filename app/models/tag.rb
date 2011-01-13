class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :synonms
  index :name, :unique => true
  
  references_many :taggings

  validates_presence_of :name
  validates_uniqueness_of :name

  scope :named, lambda {|name| {:where => { :name => name } }}

  def self.find_or_create_named(name)
    tag = Tag.named(name).first
    if tag.nil?
      tag = Tag.new(:name => name)
      tag.save!
    end
    return tag
  end
  
  def ==(object)
    super || (object.is_a?(Tag) && name == object.name)
  end

  def to_s
    name
  end
end