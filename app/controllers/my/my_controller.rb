class My::MyController < ApplicationController
  before_filter :authenticate_user!
  
end