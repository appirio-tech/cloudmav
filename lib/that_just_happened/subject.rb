
module ThatJustHappened
  module Subject
    
    def self.included(receiver)
      receiver.class_eval do
        references_many :happenings
      end
            
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def just(name, actor, options= {})
        options[:category] ||= "general"
        h = Happening.new(:name => name, :category => options[:category])
        self.happenings << h
        actor.happening = h
        self.save
        actor.save
      end
    end
  end
end