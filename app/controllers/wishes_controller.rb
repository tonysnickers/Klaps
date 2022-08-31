class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wish)
    @wish = Wish.where(user_id: current_user.id)
    @wish.where(wish: true)
  end

  def create
    @group = Group.find(params[:group_id])
    @wish = Wish.where(user: current_user, movie_id: params_wish[:movie_id]).first_or_initialize
    authorize @wish
    @wish.save
    flash.alert = "Added to your wishlist!"
    redirect_to group_movies_path(@group)
  end

  def add
    @movie_title = params["q"]
    @movie = Movie.where(name: @movie_title)
    @wish = Wish.new(user: current_user, movie: @movie.first)

    if @movie_title.empty?
      flash.alert = "You have to enter a title"
    elsif @movie.empty?
      flash.alert = "Sorry, I don't know this movie..."
    elsif Wish.where(user: current_user, movie_id: @movie.first.id).exists?
      flash.alert = "Already in your wishlist"
    else
      flash.alert = "Added to your wishlist !"
      @wish.save!
    end
    authorize @wish
    redirect_to wishes_path
  end

  def destroy
    @wish = Wish.find(params[:id])
    authorize @wish
    @wish.destroy
    flash.alert = "Removed successfully!"
    redirect_to wishes_path
  end


  private

  def params_wish
    params.require(:wish).permit(:movie_id)
  end
end
