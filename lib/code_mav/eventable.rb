module CodeMav
  module Eventable

    def self.included(receiver)
      receiver.class_eval %Q{
        references_many :events, :inverse_of => :#{receiver.to_s.underscore}
        after_create :create_added_event
        after_save :create_updated_event
        after_destroy :create_deleted_event
      }
    
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def class_name_as_symbol
        self.class.to_s.underscore.to_sym
      end

      def create_added_event
        event_name = "#{self.class.to_s}AddedEvent"
        if Kernel.const_defined?(event_name)
          event = Kernel.const_get(event_name).new
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self)
          event.save
        end
      end

      def create_updated_event
        event_name = "#{self.class.to_s}UpdatedEvent"
        if Kernel.const_defined?(event_name)
          event = Kernel.const_get(event_name).new
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self)
          event.save
        end
      end

      def create_deleted_event
        event_name = "#{self.class.to_s}UpdatedEvent"
        if Kernel.const_defined?(event_name)
          event = Kernel.const_get(event_name).new
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self.to_json)
          event.save
        end
      end

    end
  end
end
