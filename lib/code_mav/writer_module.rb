module CodeMav
  module WriterModule
    def self.included(receiver)
      receiver.class_eval do
        has_many :blogs
        has_many :posts
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
    end
  end
end