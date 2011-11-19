class KnowledgesController < ApplicationController
  before_filter :set_profile
  
  def show
    @tab = "knowledge"
    @stack_overflow_profile = @profile.stack_overflow_profile
  end
  
  def edit
    @tab = "knowledge"
    @stack_overflow_profile = @profile.stack_overflow_profile
  end
  
end