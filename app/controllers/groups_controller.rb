class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update]

  def index
    @groups = Group.where(archive: false) # Scope avec Pundit
    #@groups = Group.all
  end

  def show() end

  def new
    @group = Group.new
    @group_user = GroupUser.new
  end

  def create
    @group = Group.new(params_group)
      @group.user = current_user
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
    @group.update(archive: true)
    redirect_to groups_path, status: :see_other
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def params_group
    params.require(:group).permit(:name)
  end
end
