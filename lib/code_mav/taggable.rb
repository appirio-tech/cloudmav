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

      def tags?
        self.taggings.count > 0
      end

      def retag!
        return if TagEvent.pending.tag_for(self.id).first

        event_name = "#{self.class.to_s}TagEvent"
        event = nil
        if Object.const_defined?(event_name)
          event = Object.const_get(event_name).new
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
        tag_name = tag.respond_to?(:name) ? tag.name : tag 
        tags.map{|t| t.downcase}.include?(tag_name.downcase)
      end

      def get_tagging(name)
        self.taggings.select{|t| t.tag.name == name}.first
      end
      
      def clear_tags!
        self.taggings.destroy_all
      end

      def taggings_by_score
        self.taggings.sort{|x,y| y.score <=> x.score}
      end

      def top_tags(options = {})
        count = options[:count] || 3
        taggings_by_score.take(count)
      end

    end
  end
end
