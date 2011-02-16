module CodeMav
  module Taggable
    def self.included(receiver)
      receiver.class_eval do
        field :tags_text, :type => String

        references_many :taggings
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def retag!
        return if TagEvent.pending.tag_for(self.id).first

        event_name = "#{self.class.to_s}TagEvent"
        event = nil
        if Kernel.const_defined?(event_name)
          event = Kernel.const_get(event_name).new
        else
          event = TagEvent.new
        end

        event.taggable_id = self.id
        event.class_name = self.class.to_s
        event.save
      end

      def tags
        self.taggings.map{|t| t.tag.name }
      end

      def all_tags
        self.taggings.map{|t| t.tag.synonyms}.flatten
      end
      
      def has_tag?(tag)
        tags.include?(tag)
      end

      def get_tagging(name)
        self.taggings.select{|t| t.tag.name == name}.first
      end
      
      def clear_tags!
        self.taggings.destroy_all
      end

    end
  end
end
