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
        return if self.pending_tagging

        self.pending_tagging = true
        self.save
        
        job_name = "Tag#{self.class.to_s}Job"
        job = nil
        if Object.const_defined?(job_name)
          job = Object.const_get(job_name)
          Resque.enqueue(job, self.id)
        end
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

    end
  end
end
