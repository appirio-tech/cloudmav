module CodeMav
  module Syncable
    def self.included(receiver)
      receiver.class_eval do
        field :last_synced_date, :type => DateTime
      end

      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def synced?
        !self.last_synced_date.nil?
      end

      def sync!
        save
        job_name = "Sync#{self.class.to_s}Job"
        if Object.const_defined?(job_name)
          Object.const_get(job_name).create(:id => self.id)          
        end
      end

    end
  end
end
