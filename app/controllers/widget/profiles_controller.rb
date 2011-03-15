class Widget::ProfilesController < ApplicationController
  before_filter :set_profile
  layout nil
  session :off

  def show
  end

end
