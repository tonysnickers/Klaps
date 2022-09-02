class FavoritesController < ApplicationController
  def index
    @favorites = policy_scope(Favorite)
    @favorite = Favorite.new
  end

  def friendsfav
    @favorite = Favorite.new
    authorize @favorite
    @friends_list = []
    current_user.friends.map do |f|
      @friends_list << f.users_friend.id
    end

    Friend.where(users_friend_id: current_user.id).map do |f|
      @friends_list << f.user.id
    end
  end

  def create
    @movie_title = params["q"]
    @movie = Movie.where(name: @movie_title)
    @favorite = Favorite.new(user: current_user, movie: @movie.first)

    if @movie_title.empty?
      flash.alert = "You have to enter a title"
    elsif @movie.empty?
      flash.alert = "Sorry, I don't know this movie..."
    elsif Favorite.where(user: current_user, movie_id: @movie.first.id).exists?
      flash.alert = "Already in your wishlist"
    else
      flash.alert = "Added to your favorites !"
      @favorite.save!
    end
    redirect_to favorites_path
    authorize @favorite
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @favorite.destroy
    flash.alert = "Removed successfully!"
    redirect_to favorites_path
  end
end
