module CodeMav
  module SpeakerModule
    def self.included(receiver)
      receiver.class_eval do
        references_many :talks
        field :speaker_bio, :type => String
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def speaker_tags
        []
      end
      
      def presentations
        presentations = []
        self.talks.each { |t| presentations.concat t.presentations }
        return presentations
      end
      
      def set_speaker_bio(bio)
        self.speaker_bio = bio
        self.just(:set_speaker_bio, self, :category => :speaking)
      end
    end
  end
end