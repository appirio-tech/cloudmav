module CodeMav
  module WriterModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :blogs
        
      end
    end
    
    
  end
end