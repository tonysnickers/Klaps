class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]

  def index
    @groups = Group.all
  end

  def show() end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params_group)
  end

  def update
    @group.archive = true
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def params_group
    params.require(:group).permit(:name, :username)
  end
end
