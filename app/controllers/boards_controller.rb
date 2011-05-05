class BoardsController < ApplicationController

  def show
    authorize! :view, "Board"
    @backlog_items = BacklogItem.all
    @events = Event.all
  end

end
