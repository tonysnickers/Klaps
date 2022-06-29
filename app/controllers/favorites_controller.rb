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
    @favorite = Favorite.new(movie: Movie.where(name: params["q"])[0], user: current_user)
    if params["q"].empty?
      flash.alert = "You have to enter a title"
    elsif Movie.where(name: params["q"]).empty?
      flash.alert = "Sorry, I don't know this movie..."
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
