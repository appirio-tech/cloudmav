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
      
      def calculate_speaker_tags
        self.talks.each do |t|
          t.taggings.each { |tagging| self.tag! tagging.tag.name }
        end
      end
    end
  end
end