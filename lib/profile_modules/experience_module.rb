module CodeMav
  module ExperienceModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :projects
        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
    end
  end
end