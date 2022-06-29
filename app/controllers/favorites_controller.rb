class FavoritesController < ApplicationController
  def index
    @favorites = policy_scope(Favorite)
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(movie: Movie.where(name: params["q"])[0], user: current_user)
    if params["q"].empty?
      flash.alert = "You have to enter a title"
    elsif Movie.where(name: params["q"]).empty?
      flash.alert = "Sorry, I don't know this movie..."
    else
      flash.alert = "Added to your favorites !"
      @favorite.save!
    # else
    #   flash.alert = "Already in your favorites"
    end

    redirect_to favorites_path
    authorize @favorite

    # @favorite = Favorite.where(user: current_user, movie_id: params_favorite[:movie_id]).first_or_initialize
    # authorize @favorite
    # @favorite.save
    # flash.alert = "Added to your favorites!"
    # redirect_to favorites_path
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @favorite.destroy
    flash.alert = "Removed successfully!"
    redirect_to favorites_path
  end

end
