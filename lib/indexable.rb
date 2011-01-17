module CodeMav
  module Indexable
    def self.included(receiver)
      receiver.class_eval do
        after_save :add_to_index
        after_destroy :remove_from_index
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      private
        def add_to_index
          return if Rails.env.test?
          Sunspot.index!(self) 
        rescue Errno::ECONNREFUSED
          puts "We could not index, likely because SOLR isn't running"
        rescue RSolr::RequestError
          puts "Solr is hating"
        end

        def remove_from_index
          return if Rails.env.test?
          Sunspot.remove(self)
        rescue Errno::ECONNREFUSED
          puts "We could not index, likely because SOLR isn't running"
        rescue RSolr::RequestError
          puts "Solr is hating"
        end
    end
  end
end