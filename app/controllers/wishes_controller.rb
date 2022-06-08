class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wishe)
    @w = Wishe.where(user_id: current_user.id)
    @w.where(wish: true)
  end

  def create
    @group = Group.find(params[:group_id])

    @wishe = Wishe.where(user: current_user, movie_id: params_wishe[:movie_id]).first_or_initialize
    authorize @wishe
    @wishe.save
    flash.alert = "Added to your wishlist!"
    redirect_to group_movies_path(@group)
  end

  private

  def params_wishe
    params.require(:wishe).permit(:movie_id)
  end
end
