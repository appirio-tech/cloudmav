class WritingsController < ApplicationController
  before_filter :set_profile
  
  def show
    @tab = "writing"
  end
  
end