require 'geokit'

module CodeMav
  module Locatable
    def self.included(receiver)
      receiver.class_eval do
        field :lat, :type => Float
        field :lng, :type => Float
        field :location, :type => String
        field :coordinates, :type => Array
 
        index [[ :coordinates, Mongo::GEO2D ]]

        before_save :update_coordinates

        def near_loc(location)
          response = Geokit::Geocoders::MultiGeocoder.geocode(location)
          near(:coordinates => [response.lat, response.lng, 1])
        end   
        
        def geocode(location)
          response = Geokit::Geocoders::MultiGeocoder.geocode(location)
          return [response.lat, response.lng]
        end

      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def update_coordinates
        unless lat.nil? || lng.nil?
          self.coordinates = [lat, lng]
        end
      end

      def location_text
        return "not set" if location.nil?
        location
      end
  

    end

  
  end
end
