class BacklogItemsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  def index
    @backlog_items = BacklogItem.all.order_by(:created_at.desc)
    @events = ProfileEvent.public.order_by(:date.desc).paginate(:page => 1, :per_page => 10)
  end

  def new
    authorize! :create, BacklogItem
    @backlog_item = BacklogItem.new
  end

  def create
    authorize! :create, BacklogItem
    @backlog_item = BacklogItem.new(params[:backlog_item])
    @backlog_item.author = current_profile
    
    if @backlog_item.save
      @backlog_item.retag!
      flash[:notice] = "Backlog Item added"
      redirect_to backlog_path
    else
      render :new
    end
  end

  def edit
    authorize! :edit, BacklogItem
    @backlog_item = BacklogItem.find(params[:id])
  end

  def update
    @backlog_item = BacklogItem.find(params[:id])
    if @backlog_item.update_attributes(params[:backlog_item])
      @backlog_item.retag!
      flash[:notice] = "Backlog Item updated"
      redirect_to backlog_path
    else
      render :edit
    end
  end

end
