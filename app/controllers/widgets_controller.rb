class WidgetsController < ApplicationController
  before_filter :set_profile

  def index
    authorize! :view_widgets, @profile
    @host = request.host
  end

end
