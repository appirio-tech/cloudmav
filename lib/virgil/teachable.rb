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
        return if has_knowledge?(guidance)
        k = Knowledge.new
        k.guidance = guidance
        new_knowledge = Knowledge.new(:guidance => guidance)
        self.knowledges << new_knowledge
      end
      
      def get_guidance
        ids = self.knowledges.map{ |k| k.guidance_id }
        Guidance.unlearned_by(self).asc(:priority).first
      end
    end
  end
end