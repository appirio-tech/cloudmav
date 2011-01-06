
module ThatJustHappened
  module HappenOn
    
    def self.included(receiver)
      receiver.class_eval do
        embeds_many :occurences
      end
            
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def just(subject, category, name)
        o = Occurence.new(:name => name, :category => :category)
        self.occurences << o
        subject.occurence = o
        self.save
        subject.save
      end
    end
  end
end