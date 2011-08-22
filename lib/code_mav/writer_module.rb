module CodeMav
  module WriterModule
    def self.included(receiver)
      receiver.class_eval do        
        references_many :blogs
        references_many :posts        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
    end
  end
end
