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
        tag = Tag.named(tag).first
        return false if tag.nil?
        !self.taggings.where(:tag_id => tag.id).first.nil?
      end
      
      def tags_text
        return "" if self.taggings.nil?
        self.taggings.join(", ")
      end

      def tags_text=(value)
        tag_names = value.split(',')
        tag_names.each do |tag_name|
          unless self.has_tag? tag_name
            tagging = Tagging.new
            tagging.tag = Tag.find_or_create_named(tag_name) 
            tagging.save
            self.taggings << tagging
            self.save
          end
        end
      end

    end
  end
end