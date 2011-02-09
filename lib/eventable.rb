module CodeMav
  module Eventable

    def self.included(receiver)
      receiver.class_eval %Q{
        references_many :events, :inverse_of => #{receiver.class_name_as_symbol}
        after_create :create_added_event
      }
    
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def class_name_as_symbol
        self.class.to_s.underscore.to_sym
      end

      def create_added_event
        event_name = "Added#{self.class.to_s}Event"
        event_class = Kernel.const_get(event_name)
        if event_class
          event = event_class.new
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self)
          event.create
        end
      end

    end
  end
end
