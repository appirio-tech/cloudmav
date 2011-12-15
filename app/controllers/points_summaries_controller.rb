class PointsSummariesController < ApplicationController
  before_filter :set_profile
  
  def show
    @list = PointsSummaryPresenter.get_list(@profile)
  end
  
end