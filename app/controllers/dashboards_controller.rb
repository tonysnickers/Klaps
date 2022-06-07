class DashboardsController < ApplicationController
  def dashboard
    # @movies = policy_scope(Movie)
    # @movies_max = []
    # @movies = @movies_max.tally.max_by(5) { |key, value| value }.map { |a| a[0] }
  end

  def index
    @current_user = current_user.id
  end
end
