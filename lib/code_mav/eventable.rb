module CodeMav
  module Eventable

    def self.included(receiver)
      receiver.class_eval %Q{
        references_many :events, :inverse_of => :#{receiver.to_s.underscore}
        after_create :create_added_event
        after_update :create_updated_event
        after_destroy :create_deleted_event
      }
    
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def save_without_events
        turn_off_events
        save
        turn_on_events
      end

      def turn_off_events
        self.class.skip_callback(:create, :after, :create_added_event)
        self.class.skip_callback(:update, :after, :create_updated_event)
        self.class.skip_callback(:destroy, :after, :create_deleted_event)
      end

      def turn_on_events
        self.class.set_callback(:create, :after, :create_added_event)
        self.class.set_callback(:update, :after, :create_updated_event)
        self.class.set_callback(:destroy, :after, :create_deleted_event)
      end

      def create_added_event
        create_event_named("#{self.class.to_s}AddedEvent")
      end

      def create_updated_event
        create_event_named("#{self.class.to_s}UpdatedEvent")
      end

      def create_deleted_event
        create_event_named("#{self.class.to_s}DeletedEvent", :self_value => self.to_json)
      end

      private

      def create_event_named(event_name, options = {})
        if Kernel.const_defined?(event_name)
          #puts "************************"
          #puts "creating event #{event_name} > #{self.inspect}"
          event = Kernel.const_get(event_name).new
          event.subject_class_name = self.class.to_s
          event.subject_id = self.id
          event.send("#{self.class.to_s.underscore}=", options[:self_value] || self)
          event.save
          #puts "Events now #{Event.all.to_a}"
          #puts "************************"
        end
      end

    end
  end
end
