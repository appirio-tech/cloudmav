module Virgil
  module Teachable
    def self.included(receiver)
      receiver.class_eval do
        embeds_many :knowledges
      end

      ::Knowledge.class_eval %Q{
        embedded_in :#{receiver.to_s.underscore}, :inverse_of => :knowledge
      }
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def has_knowledge?(guidance)
        self.knowledges.select{|k| k.guidance == guidance }.any?
      end
      
      def learn(name)
        guidance = Guidance.where(:title => name).first
        return if has_knowledge?(guidance) or guidance.nil?
        knowledge = Knowledge.new(:guidance_id => guidance.id)
        self.knowledges << knowledge
        knowledge.save
      end
      
      def knows?(title)
        guidance = Guidance.where(:title => title).first
        return false if guidance.nil?
        has_knowledge?(guidance)
      end
      
      def get_guidance
        Guidance.unlearned_by(self).asc(:priority).first
      end
    end
  end
end