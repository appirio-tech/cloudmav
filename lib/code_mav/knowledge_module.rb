module CodeMav
  module KnowledgeModule
    def self.included(receiver)
      receiver.class_eval do

        references_one :knowledge_profile, :inverse_of => :profile

        references_one :stack_overflow_profile

        before_create :create_knowledge_profile
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def create_knowledge_profile
        self.knowledge_profile = KnowledgeProfile.new
      end

    end
  end
end


