
module CodeMav
  module HasBacklogItems
    def self.included(receiver)
      receiver.class_eval do

        has_many :backlog_items
        embeds_many :backlog_item_recommendations

        index "backlog_item_recommendations.backlog_item_id"
      end
      
      receiver.send(:include, InstanceMethods)
      receiver.send(:extend, ClassMethods)
    end
    
    module ClassMethods


    end

    module InstanceMethods


    end
  
  end
end

