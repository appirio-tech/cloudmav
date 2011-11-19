class Admin::BaseController < ApplicationController
  before_filter :check_if_admin
  
  def check_if_admin
    authorize! :admin, Profile
  end
end