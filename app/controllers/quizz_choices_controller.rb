require 'open-uri'

class QuizzChoicesController < ApplicationController
  before_action :find_quizz_choice, only: %i[edit add_keyword add_duration add_date add_actor change_step]

  def new
    @group = Group.find(params[:group_id])
    @quizz_choice = QuizzChoice.new
    authorize @quizz_choice
  end

  def create
    @quizz_choice = QuizzChoice.new(quizz_choice_params)
    @quizz_choice.group = Group.find(params[:group_id])
    @quizz_choice.user = current_user

    @quizz_choice.genre = params["quizz_choice"]["genre"].reject(&:empty?)

    authorize @quizz_choice

    if @quizz_choice.save
      redirect_to edit_quizz_choice_path(@quizz_choice)
    else
      render :new
    end
  end

  def index
    @quizz_choices = policy_scope(QuizzChoice)
    @group = Group.find(params[:group_id])
    @quizz_choices = @group.quizz_choices.where(user: current_user)
  end

  def edit
    authorize @quizz_choice
    (1...2).each do |page_number|
      actors = JSON.parse(URI.open("https://api.themoviedb.org/3/person/popular?api_key=5a07d55b0507c919cb598bae7c6fd7b4&page=#{page_number}").read)["results"]
      @actor_list = []
      actors.each do |act|
        @actor_list << act['name']
      end
    end
  end

  def change_step
    authorize @quizz_choice
    @quizz_choice = QuizzChoice.find(params[:id])
    @old_step = @quizz_choice.step
    case @quizz_choice.step
    when "add_keyword"
      @quizz_choice.step = "initial"
    when "add_duration"
      @quizz_choice.step = "add_keyword"
    when "add_date"
      @quizz_choice.step = "add_duration"
    when "add_actor"
      @quizz_choice.step = "add_date"
    end
    @quizz_choice.save!
    @new_step = @quizz_choice.step
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_keyword
    @quizz_choice.keyword = params["quizz_choice"]["keyword"].reject(&:empty?)

    authorize @quizz_choice
    # raise
    @quizz_choice.keyword = params["quizz_choice"]["keyword"]

    @quizz_choice.step = "add_keyword"
    @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_duration
    authorize @quizz_choice
    @quizz_choice.duration = params["quizz_choice"]["duration"]
    @quizz_choice.step = "add_duration"
    @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_date
    authorize @quizz_choice
    @quizz_choice.update(quizz_choice_params)
    @quizz_choice.step = "add_date"
    @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_actor
    authorize @quizz_choice
    @quizz_choice.actor = params["q"]
    @quizz_choice.step = "add_actor"
    @quizz_choice.save!
    redirect_to group_quizz_choices_path(@quizz_choice.group)
    # **********
    # LA OU LA MAGIE OPERE
  end

  private

  def find_quizz_choice
    # authorize @quizz_choice
    @quizz_choice = QuizzChoice.find(params[:id])
  end

  def quizz_choice_params
    params.require(:quizz_choice).permit(:genre, :duration, :actor, :keyword, :start_year, :end_year)
  end
end

# @quizz_choice = QuizzChoice.new( ... , step: "initial")
