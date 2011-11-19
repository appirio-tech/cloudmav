class LoggedInController < ApplicationController
  before_filter :set_profile
  before_filter :authenticate_user!
end