class FriendsController < ApplicationController
  def index
    @friends = policy_scope(Friend)
    @friend = Friend.new
  end

  def create
    params[:friend][:users_friend_id].reject(&:empty?).each do |id|
      user = User.find(id.to_i)
      @friend = Friend.new(users_friend: user, user: current_user)
      if (user != current_user) && ((!current_user.friends.map(&:users_friend).include?(user)) && (!user.friends.map(&:users_friend).include?(current_user)))
        @friend.save!
      else
        p "You are already friends!"
      end
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
