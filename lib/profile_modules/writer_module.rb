module CodeMav
  module WriterModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :blogs
        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      
      def blog_posts
        posts = []
        self.blogs.each { |b| posts.concat b.posts }
        return posts
      end
      
    end
  end
end