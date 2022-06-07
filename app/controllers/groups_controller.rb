class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :compute_results, :results]

  def index
    @groups = policy_scope(Group)
  end

  def show
    authorize @group
  end

  def new
    @group = Group.new
    authorize @group
    @group_user = GroupUser.new
    @friends = current_user.friends.map(&:users_friend)
    @friends << Friend.where(users_friend: current_user).map(&:user)
    @friends.flatten!
  end

  def create
    @group = Group.new(params_group)
    @group.user = current_user

    authorize @group

    if (params["group"]["user_id"].count > 1) && @group.save
      @user_ids = params[:group][:user_id]
      @user_ids.each do |id|
        group_user = GroupUser.new(user_id: id, group_id: @group.id)
        group_user.save
      end
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    authorize @group
    @group.update(archive: true)
    redirect_to groups_path, status: :see_other
  end

  def compute_results
    if params["ordered_choice"]["movie_order"].split(',').length == 1
      @ids = params["ordered_choice"]["movie_order"].split(' ')
    else
      @ids = params["ordered_choice"]["movie_order"].split(',')
    end
    authorize @group
    @points = [5, 4, 3, 2, 1]
    @ids.each do |movie_id|
      if OrderedChoice.find_by(movie: Movie.find(movie_id.to_i), group: @group)
        oc = OrderedChoice.find_by(movie: Movie.find(movie_id.to_i), group: @group)
        oc.update(point: oc.point += @points[@ids.index(movie_id)])
      else
        OrderedChoice.create(movie: Movie.find(movie_id.to_i), group: @group, point: @points[@ids.index(movie_id)])
      end
    end
    h = {}
    OrderedChoice.where(group: @group).each do |oc|
      h[oc.movie_id] = oc.point
    end
    @final = Movie.find(h.sort_by {|k, v| v}.reverse.first.first)
    redirect_to results_group_path(@group)
  end

  def results
    authorize @group
    h = {}
    OrderedChoice.where(group: @group).each do |oc|
      h[oc.movie_id] = oc.point
    end
    @final = Movie.find(h.sort_by {|k, v| v}.reverse.first.first)
    # redirect_to results_group_path(@group)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def params_group
    params.require(:group).permit(:name)
  end
end
