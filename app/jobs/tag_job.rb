class TagJob < Resque::JobWithStatus
  @queue = :tag
  attr_accessor :taggable
  
  def perform
    set_taggable(options[:id])
    @taggable.clear_tags!
    set_tags_from_tags_text
    tag
    @taggable.save
    retag_related_items!
  end
  
  def set_tags_from_tags_text
    return if @taggable.tags_text.nil?

    @taggable.tags_text.split(',').map{|s| s.strip}.each do |t|
      @taggable.tag t
    end
  end
  
  def retag_related_items!
    @taggable.related_items.each do |i|
      i.retag!
    end
  end
  
  def import_tags_from(other_taggable)
    return if other_taggable.nil?

    other_taggable.taggings.each do |tagging|
      @taggable.tag tagging.tag.name, :count => tagging.count, :score => tagging.score
    end
  end
  
end