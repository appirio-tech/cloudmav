module CodeMav
  module Synchable
    def self.included(receiver)
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def synch!
        event_name = "#{self.class.to_s}SynchEvent"
        if Kernel.const_defined?(event_name)
          event = Kernel.const_get(event_name).new
          event.subject_class_name = self.class.to_s
          event.subject_id = self.id
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self)
          event.save
        end
        save
      end

    end
  end
end
