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
        things_to_discover = ["GitHub"]
        result = self.autodiscover_histories.any_in(name: things_to_discover)
        puts "reuslt is #{result.to_a}"
        result.count == things_to_discover.count
      end

    end
  end
end

