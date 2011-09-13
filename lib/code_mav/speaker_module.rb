module CodeMav
  module SpeakerModule
    def self.included(receiver)
      receiver.class_eval do
        has_many :talks
        has_one :speaker_profile
        has_one :speaker_rate_profile
        has_one :slide_share_profile

        before_create :create_speaker_profile
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def create_speaker_profile
        self.speaker_profile = SpeakerProfile.new
      end

    end
  end
end
