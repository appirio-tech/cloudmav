module CodeMav
  module SpeakerModule
    def self.included(receiver)
      receiver.class_eval do
        references_many :talks, :inverse_of => :profile
        references_one :speaker_profile, :inverse_of => :profile

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
