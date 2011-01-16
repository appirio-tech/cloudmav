module CodeMav
  module Taggable
    def self.included(receiver)
      receiver.class_eval do
        references_many :taggings
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def tags
        self.taggings.map{|t| t.tag.name }
      end
      
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
      
      def tag!(tag, options={})
        options[:count] ||= 1
        options[:score] ||= 1
        
        tagging = get_tagging(tag)
        if tagging.nil?
          tagging = Tagging.new
          tagging.tag = Tag.find_or_create_named(tag) 
        end
        tagging.count += options[:count]
        tagging.score += options[:score]
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