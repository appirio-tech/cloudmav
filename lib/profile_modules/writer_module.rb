module CodeMav
  module WriterModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :blogs
        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      

    end
  end
end