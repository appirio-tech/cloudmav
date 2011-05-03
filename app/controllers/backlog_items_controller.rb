class BacklogItemsController < ApplicationController

  def index
    @backlog_items = BacklogItem.all.order_by(:created_at.desc)
  end

  def new
    authorize! :create, BacklogItem
    @backlog_item = BacklogItem.new
  end

  def create
    authorize! :create, BacklogItem
    @backlog_item = BacklogItem.new(params[:backlog_item])
    
    if (@backlog_item.save)
      flash[:notice] = "Backlog Item added"
      redirect_to backlog_path
    else
      render :new
    end
  end

end
