module CodeMav
  module Taggable
    def self.included(receiver)
      receiver.class_eval do
        references_many :taggings
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def has_tag?(tag)
        !get_tagging(tag).nil?
      end
      
      def get_tagging(tag)
        t = Tag.named(tag).first
        return nil if t.nil?
        self.taggings.select{|tagging| tagging.tag == t}.first
      end
      
      def tags_text
        return "" if self.taggings.nil?
        self.taggings.join(", ")
      end
      
      def find_or_create_tagging(tag)
        tagging = get_tagging(tag)
        return tagging unless tagging.nil?
        
        tag!(tag)
        return get_tagging(tag)
      end
      
      def tag!(tag)
        tagging = Tagging.new
        tagging.tag = Tag.find_or_create_named(tag) 
        tagging.save
        self.taggings << tagging
        self.save
      end

      def tags_text=(value)
        tag_names = value.split(',')
        tag_names.each do |tag_name|
          unless self.has_tag? tag_name
            self.tag!(tag_name)
          end
        end
      end
      
      def all_tags
        self.taggings.map{|t| t.tag.synonyms }.flatten
      end
    end
  end
end