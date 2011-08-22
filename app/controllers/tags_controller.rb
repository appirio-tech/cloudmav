class TagsController < ApplicationController
  before_filter :can_manage_tags?
  
  def index
    @tags = Tag.paginate(:page => params[:page], :per_page => 20)
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      flash[:notice] = "Tag #{@tag.name} created"
      redirect_to tags_path
    else
      render :new
    end
  end
  
  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
    
    if @tag.update_attributes(params[:tag])
      flash[:notice] = "Tag #{@tag.name} updated"
      redirect_to tags_path
    else
      render :edit
    end
  end
  
  private
    def can_manage_tags?
      authorize! :manage, Tag
    end
  
end