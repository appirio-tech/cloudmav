class StackOverflowProfilesController < ApplicationController
  before_filter :set_profile, :only => [:new, :create]
  
  def new
    authorize! :set_stack_overflow_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.new
  end
  
  def create
    authorize! :set_stack_overflow_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.new(params[:stack_overflow_profile])
    @stack_overflow_profile.profile = @profile
    @stack_overflow_profile.synch!
        
    redirect_to profile_code_path(@profile)
  end
  
end