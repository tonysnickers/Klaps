class FriendsController < ApplicationController
  def index
    @friends = policy_scope(Friend)
    @friend = Friend.new
  end

  def new
    @friend = Friend.new
    authorize @friend
  end

  def create
    params[:friend][:users_friend_id].reject(&:empty?).each do |id|
      @friend = Friend.new(users_friend: User.find(id.to_i), user: current_user)
      @friend.save! if ((User.find(id.to_i) != current_user) && (Friend.where(user_id: current_user.id).where(users_friend_id: id).empty?) && (Friend.where(user_id: id).where(users_friend_id: current_user.id).empty?))
    end
    redirect_to friends_path
    authorize @friend
  end

  def delete
    raise
    @friend = Friend.find(params[:id])
  end

  # private

  # def params_friend
    # params.require(:friend).permit(:id)
  # end
end
