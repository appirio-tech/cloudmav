module CodeMav
  module WriterModule
    def self.included(receiver)
      receiver.class_eval do
        has_one :writer_profile
        has_many :blogs
        has_many :posts
        
        before_create :create_writer_profile
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def create_writer_profile
        self.writer_profile = WriterProfile.new
      end
      
    end
  end
end
