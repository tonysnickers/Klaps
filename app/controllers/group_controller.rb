class GroupController < ApplicationController
  before_action :set_group, only [:show, :edit, :update]

  def index
    @group = Group.all
  end

  def show() end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params_group)
  end

  def edit

  end

  def update

  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def params_group
    params.require(:group).permit(:name, :username)
  end
end
