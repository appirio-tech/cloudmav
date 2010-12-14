module CodeMav
  module SpeakerModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :talks
        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
    end
  end
end