class UserGroupsController < ApplicationController
  
  def index
    @user_groups = UserGroup.all
  end
  
  def show
    @user_group = UserGroup.find(params[:id])
  end
  
  def new
    @user_group = UserGroup.new
  end
  
  def create
    @user_group = UserGroup.new(params[:user_group])
    
    if @user_group.save
      redirect_to @user_group
    else
      render :new
    end
  end
  
end