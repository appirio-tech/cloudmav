module CodeMav
  module ExperienceModule
    def self.included(receiver)
      receiver.class_eval do
        has_many :jobs
        has_one :experience_profile

        #has_one :linkedin_profile
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def create_experience_profile
        self.experience_profile = ExperienceProfile.new 
      end
      
      def has_job?(title)
        self.jobs.where(:title => title).first
      end

    end
  end
end
