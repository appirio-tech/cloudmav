class ExperiencesController < ApplicationController
  before_filter :set_profile
  
  def show
    @tab = "experience"
  end
  
  def edit
    @linkedin_profile = @profile.linkedin_profile
  end
  
end