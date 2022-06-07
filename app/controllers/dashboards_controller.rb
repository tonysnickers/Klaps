class DashboardsController < ApplicationController
  def dashboard
  end

  def index
    @current_user = current_user.id
  end
end
