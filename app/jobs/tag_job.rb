class TagJob
  @queue = :tag
  
  def self.perform(id, klass_string)
    return unless klass_string.is_a_constant?    
    taggable = klass_string.constantize.find(id)

    tag(taggable)
  end
  
  def self.tag(taggable)
    taggable.clear_tags!
    taggable.set_tags_from_tags_text
    taggable.generate_tags
    taggable.save 
    
    taggable.related_items.each do |t|
      tag(t) unless t.nil?
    end
  end

end