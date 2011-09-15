module CodeMav
  module Taggable
    def self.included(receiver)
      receiver.class_eval do
        field :tags_text, :type => String
        field :pending_tagging, :type => Boolean, :default => false
        
        has_many :taggings, :as => :taggable
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def clear_tags!
        self.taggings.destroy_all
      end
      
      def retag!
        return false if self.pending_tagging
        Resque.enqueue(TagJob, self.id, self.class.to_s)
        return true
      end
      
      def tag(tag, options={})
        options[:count] ||= 1
        options[:score] ||= 1

        t = Tag.find_or_create_named(tag)
        tagging = self.taggings.select{|tagging| tagging.tag == t}.first
        if tagging.nil?
          tagging = self.taggings.build
          tagging.tag = t
        end
        tagging.count += options[:count]
        tagging.score += options[:score]
        tagging.save
        self.reload
      end
      
      def tags
        self.taggings.map{|t| t.tag.name }
      end
      
      def set_tags_from_tags_text
        return if self.tags_text.nil?

        self.tags_text.split(',').map{|s| s.strip}.each do |t|
          self.tag t
        end
      end
      
      def import_tags_from(other_taggable)
        return if other_taggable.nil?

        other_taggable.taggings.each do |tagging|
          self.tag tagging.tag.name, :count => tagging.count, :score => tagging.score
        end
      end
      
      def taggings_by_score
        self.taggings.sort{|x,y| y.score <=> x.score}
      end
      
      def has_tag?(tag)
        tag_name = tag.respond_to?(:name) ? tag.name : tag 
        tags.map{|t| t.downcase}.include?(tag_name.downcase)
      end
      
      def get_tagging(name)
        self.taggings.select{|t| t.tag.name == name}.first
      end
      
      def all_tags
        self.taggings.map{|t| t.tag.synonyms}.flatten
      end
    end
  end
end
