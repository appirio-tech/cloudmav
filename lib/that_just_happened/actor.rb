module ThatJustHappened
  module Actor
    def self.included(receiver)
      receiver.class_eval do
        references_one :happening
      end
            
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

    end
  end
end