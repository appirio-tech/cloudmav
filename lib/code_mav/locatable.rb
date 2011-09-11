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
        index :location

        before_save :update_coordinates

        scope :with_location, where(:location.exists => true).not_in(:location => [""])
      end
      
      receiver.send(:include, InstanceMethods)
      receiver.send(:extend, ClassMethods)
    end
    
    module ClassMethods

      def near_loc(location)
        response = Geokit::Geocoders::MultiGeocoder.geocode(location)
        near(:coordinates => [response.lat, response.lng, 1])
      end   

      def near_locatable(locatable, options = {})
        distance = options[:distance] || 1
        near(:coordinates => [locatable.lat, locatable.lng, distance])
      end

    end

    module InstanceMethods

      def has_location?
        !self.coordinates.nil?
      end

      def geocode(location)
        response = Geokit::Geocoders::MultiGeocoder.geocode(location)
        return [response.lat, response.lng]
      end

      def update_coordinates
        return if Rails.env.test?
        return if location.nil? || location.blank?

        if lat.nil? || lng.nil?
          response = Geokit::Geocoders::MultiGeocoder.geocode(location)
          self.lat = response.lat
          self.lng = response.lng
        end

        self.coordinates = [self.lat, self.lng]
      end

      def location_text
        return "not set" if location.blank?
        location
      end
  
      def geoloc
        Geokit::GeoLoc.new(:lat => latitude, :lng => longitude)
      end

      def distance_to(other)
        if other.respond_to?(:coordinates)
          geoloc.distance_to(other.coordinates)
        else
          geoloc.distance_to(other)
        end
      end

    end
  
  end
end
