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

      def retag
        unless TagEvent.pending_for(self.id).first
          TagEvent.create(:taggable_id => self.id, :class_name => self.class.to_s)
        end
      end

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
      
      def tag!(tag, options={})
        tag(tag, options)
        self.save
      end

      def tag(tag, options={})
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
      end

      def calculate_tags!
        set_tags_from_tags_text
        set_other_tags if self.respond_to?(:set_other_tags)
        self.tags_text = @tags.join(", ")
        self.save
      end

      def set_tags_from_tags_text
        self.tags_text.split(',').map{|s| s.strip}.each do |t|
          self.tag t
        end
      end
      
      def all_tags
        self.taggings.map{|t| t.tag.synonyms }.flatten
      end

      def find_tags_in(s, tags)
        tags = []
        Tag.all.each do |tag|
          tag.synonyms.each do |syn|
            tags << tag.name if s.include?(syn)
          end 
        end
        return tags
      end

      def clear_tags!
        self.taggings.destroy_all
      end
    end
  end
end
