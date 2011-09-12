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
        if job_name.is_a_constant?
          job = job_name.constantize
          Resque.enqueue(job, self.id)
          return true        
        end
        return false
      end
      
      def resync!
        save
        job_name = "Resync#{self.class.to_s}Job"
        if job_name.is_a_constant?
          job = job_name.constantize
          Resque.enqueue(job, self.id)
          return true        
        end
        return false        
      end

    end
  end
end
