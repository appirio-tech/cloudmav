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
      
      def presentations
        presentations = []
        self.talks.each { |t| presentations.concat t.presentations }
        return presentations
      end

      def speaker_tags
        speaker_profile.tags
      end
      
      def calculate_speaker_tags
        self.speaker_profile.clear_tags!

        self.talks.each do |talk|
          talk.tags.each{|tag| speaker_profile.tag! tag }
        end
      end
    end
  end
end
