class MeetingsController < ApplicationController
  before_filter :set_user_group
  
  def new
    @meeting = @user_group.schedule_new_meeting
  end
  
  def create
    @meeting = @user_group.meetings.build(params[:meeting])

    if @meeting.save
      redirect_to @user_group
    else
      render :new
    end
  end
  
  def set_user_group
    @user_group = UserGroup.find(params[:user_group_id])
  end
end