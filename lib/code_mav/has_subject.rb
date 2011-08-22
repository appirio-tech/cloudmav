module CodeMav

  module HasSubject
    def self.included(receiver)
      receiver.class_eval do
        field :subject_id, :type => String
        field :subject_class_name, :type => String
      end
   
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def subject_class
        Object.const_get(subject_class_name)
      end

      def subject
        subject_class.find(subject_id)
      end

      def subject=(value)
        self.subject_id = value.id
        self.subject_class_name = value.class 
      end

    end

  end

end
