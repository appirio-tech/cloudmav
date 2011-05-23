class StackOverflowProfilesController < ApplicationController
  before_filter :set_profile
  
  def new
    authorize! :set_stack_overflow_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.new
  end
  
  def create
    authorize! :set_stack_overflow_profile, @profile
    @stack_overflow_profile = StackOverflowProfile.new(params[:stack_overflow_profile])
    @stack_overflow_profile.profile = @profile
    @stack_overflow_profile.sync!
        
    redirect_to profile_code_path(@profile)
  end

  def edit
    authorize! :set_stack_overflow_profile, @profile
    @stack_overflow_profile = @profile.stack_overflow_profile
  end

  def update
    authorize! :set_stack_overflow_profile, @profile
    
    if @profile.stack_overflow_profile.update_attributes(params[:stack_overflow_profile])
      @profile.stack_overflow_profile.sync!
      redirect_to profile_code_path(@profile)
    else
      render :edit
    end
  end
  
end
