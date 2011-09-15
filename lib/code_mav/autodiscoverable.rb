module CodeMav
  module Autodiscoverable
    def self.included(receiver)
      receiver.class_eval do
        embeds_many :autodiscover_histories
      end

      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def autodiscovered?
        things_to_discover = ["GitHub", "Bitbucket"]
        result = self.autodiscover_histories.any_in(:name => things_to_discover).to_a
        result.count == things_to_discover.count
      end
      
      def add_autodiscover_history_for(name)
        history = self.autodiscover_histories.where(:name => name).first
        if history.nil?
          self.autodiscover_histories.create(:name => name)
        end
      end
        
    end
  end
end