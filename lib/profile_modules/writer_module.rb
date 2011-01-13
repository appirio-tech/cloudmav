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
      
      def writer_tags
        []
      end
      
      # def blog_posts
      #   posts = []
      #   self.blogs.each { |b| posts.concat b.posts }
      #   return posts.sort{|x,y| y.written_on <=> x.written_on }
      # end
      
    end
  end
end