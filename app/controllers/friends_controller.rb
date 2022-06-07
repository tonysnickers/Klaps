class FriendsController < ApplicationController
  def index
    @friends = policy_scope(Friend)
    @friend = Friend.new
  end

  def create
    @friend = Friend.new(users_friend: User.where(username: params["q"])[0], user: current_user)
    if (@friend.users_friend != current_user) && ((!current_user.friends.map(&:users_friend).include?(@friend.users_friend)) && (!@friend.users_friend.friends.map(&:users_friend).include?(current_user)))
      @friend.save!
    else
      flash.alert = "Try another user"
    end

    redirect_to friends_path
    authorize @friend
  end

  def destroy
    @friend = Friend.find(params[:id])
    authorize @friend
    @friend.destroy
    redirect_to friends_path
  end

  # private

  # def params_friend
    # params.require(:friend).permit(:id)
  # end
end
