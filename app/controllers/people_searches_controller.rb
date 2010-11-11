require 'geokit'

class PeopleSearchesController < ApplicationController
  include Geokit::Geocoders
  
  def new
  end
  
  def create
    result = MultiGeocoder.geocode(params[:location])
    @people = Profile.near(:coordinates => [ result.lat, result.lng, 1 ])
  end
  
end