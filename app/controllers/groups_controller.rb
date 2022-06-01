class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update]

  def index
    @groups = Group.all
  end

  def show() end

  def new
    @group = Group.new
    @group_user = GroupUser.new
  end

  def create
    @group = Group.new(params_group)
    @group.user = current_user
    @group.save
    @user_ids = params[:group][:user_id]
    @user_ids.each do |id|
      group_user = GroupUser.new(user_id: id, group_id: @group.id)
      group_user.save
    end
  end

  def update
    @group.archive = true
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def params_group
    params.require(:group).permit(:name)
  end
end
