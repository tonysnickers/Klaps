class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wishe)
    @w = Wishe.where(user_id: current_user.id)
    @w.where(wish: true)
  end

  def new
    @wishe = Wishe.new
    authorize @wishe
  end

  def create
    @wishe = Wishe.new(params_wishe)
    @wishe.user = current_user
    authorize @wishe
    @wishe.save
  end

  # private

  # def params_wishe
  #   params.require(:wishe).permit(:id)
  # end
end
