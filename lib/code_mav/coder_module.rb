module CodeMav
  module CoderModule
    def self.included(receiver)
      receiver.class_eval do

        references_one :coder_profile, :inverse_of => :profile

        references_one :git_hub_profile
        references_one :bitbucket_profile
        references_one :coder_wall_profile

        before_create :create_coder_profile
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def create_coder_profile
        self.coder_profile = CoderProfile.new
      end

    end
  end
end

