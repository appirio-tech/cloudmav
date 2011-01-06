module ThatJustHappened
  module Happening
    def self.included(receiver)
      receiver.class_eval do
        embeds_one :occurence
      end
            
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

    end
  end
end