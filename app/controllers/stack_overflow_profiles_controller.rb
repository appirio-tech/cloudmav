class StackOverflowProfilesController < ApplicationController
  
  def new
    @stack_overflow_profile = StackOverflowProfile.new
  end
  
  def create
    @stack_overflow_profile = StackOverflowProfile.new(params[:stack_overflow_profile])
    StackOverflowService.synch(@stack_overflow_profile)
    @stack_overflow_profile.profile = current_profile
    
    current_profile.save!
    # @stack_overflow_profile.save!
    
    redirect_to current_profile
  end
  
end