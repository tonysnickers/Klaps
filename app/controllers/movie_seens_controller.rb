class MovieSeensController < ApplicationController
  def index
    @movie_seens = policy_scope(MovieSeen)
    @ms = MovieSeen.where(user_id: current_user.id)
    @ms.where(seen: true)
  end

  def create
    @movie_seen = MovieSeen.new(params_movie_seen)
    @movie_seen.user = current_user
    authorize @movie_seen
    @movie_seen.save
  end

  # private

  # def params_movie_seen
  #   params.require(:movie_seen).permit(:id)
  # end
end
