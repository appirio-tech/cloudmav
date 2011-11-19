module CodeMav
  module SocialModule
    def self.included(receiver)
      receiver.class_eval do

        has_one :social_profile
        has_one :twitter_profile

        before_create :create_social_profile
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def create_social_profile
        self.social_profile = SocialProfile.new
      end

    end
  end
end
