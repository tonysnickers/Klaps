class QuizzChoicesController < ApplicationController
  before_action :find_quizz_choice, only: %i[edit add_keyword add_actor add_year add_duration]

  def new
    @group = Group.find(params[:group_id])
    @quizz_choice = QuizzChoice.new
  end

  def create
    @quizz_choice = QuizzChoice.new(quizz_choice_params)
    @quizz_choice.group = Group.find(params[:group_id])
    @quizz_choice.user = current_user
    if @quizz_choice.save
      redirect_to edit_quizz_choice_path(@quizz_choice)
    else
      render :new
    end
  end

  def index
  end

  def edit
  end

  def add_keyword
    @quizz_choice.keyword = params["quizz_choice"]["keyword"]
    @quizz_choice.step = "add_keyword"
    @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_duration
    raise
    # rajouter la duration choisis à l'instance @quizz_choice
    @quizz_choice.step = "add_duration"
    # @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_date
    # rajouter la year choisis à l'instance @quizz_choice
    @quizz_choice.step = "add_date"
    # @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_actor
    # rajouter les actors choisis à l'instance @quizz_choice
    # @quizz_choice = [actor, duration, date]
    # @quizz_choice.add

    @quizz_choice.step = "add_actor"
    # @quizz_choice.save!
    # redirect_to edit_group_ordered_choice
  end

  private

  def find_quizz_choice
    @quizz_choice = QuizzChoice.find(params[:id])
  end

  def quizz_choice_params
    params.require(:quizz_choice).permit(:genre, :duration, :actor, :keyword)
  end
end

# @quizz_choice = QuizzChoice.new( ... , step: "initial")
