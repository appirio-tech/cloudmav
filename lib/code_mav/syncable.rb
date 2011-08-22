module CodeMav
  module Syncable
    def self.included(receiver)
      receiver.class_eval do
        field :last_synced_date, :type => DateTime
      end

      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def error_while_syncing?
        event_name = "#{self.class.to_s}SyncEvent"
        return false unless Object.const_defined?(event_name)

        eventClass = Object.const_get(event_name)
        event = eventClass.for_profile(self.profile).last
        return false if event.nil?

        !event.error_message.nil?
      end

      def synced?
        !self.last_synced_date.nil?
      end

      def unsync!
        event_name = "#{self.class.to_s}UnsyncEvent"
        if Object.const_defined?(event_name)
          event = Object.const_get(event_name).new
          event.subject_class_name = self.class.to_s
          event.subject_id = self.id
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self)
          event.save
        end
      end

      def resync!
        save
        event_name = "#{self.class.to_s}ResyncEvent"
        if Object.const_defined?(event_name)
          event = Object.const_get(event_name).new
          event.subject_class_name = self.class.to_s
          event.subject_id = self.id
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self)
          event.save
        end
      end

      def sync!
        save
        event_name = "#{self.class.to_s}SyncEvent"
        if Object.const_defined?(event_name)
          event = Object.const_get(event_name).new
          event.subject_class_name = self.class.to_s
          event.subject_id = self.id
          event.profile = self.profile
          event.send("#{self.class.to_s.underscore}=", self)
          event.save
        end
      end

    end
  end
end
