module CodeMav
  module SpeakerModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :talks
        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def presentations
        presentations = []
        self.talks.each { |t| presentations.concat t.presentations }
        return presentations
      end
      
    end
  end
end