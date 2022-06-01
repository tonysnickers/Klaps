class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update]

  def index
    @groups = policy_scope(Group)
    # @groups = Group.where(archive: false) # Scope avec Pundit
  end

  def show
    authorize @group
  end

  def new
    @group = Group.new
    authorize @group
    @group_user = GroupUser.new
    authorize @group_user
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
