class DashboardsController < ApplicationController
  def dashboard
    @users = User.new
  end

  def index
    @current_user = current_user.id
  end
end
