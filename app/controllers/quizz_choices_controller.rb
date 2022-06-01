require 'open-uri'

class QuizzChoicesController < ApplicationController
  before_action :find_quizz_choice, only: %i[edit add_keyword add_duration add_date add_actor]

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

  def edit
    (1...2).each do |page_number|
      actors = JSON.parse(URI.open("https://api.themoviedb.org/3/person/popular?api_key=5a07d55b0507c919cb598bae7c6fd7b4&page=#{page_number}").read)["results"]
      @actor_list = []
      actors.each do |act|
        @actor_list << act['name']
      end
    end

  end

  def add_keyword
    # raise
    @quizz_choice.keyword = params["quizz_choice"]["keyword"]
    @quizz_choice.step = "add_keyword"
    @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_duration
    # raise
    @quizz_choice.duration = params["quizz_choice"]["duration"]
    @quizz_choice.step = "add_duration"
    @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_date
    # rajouter la year choisis à l'instance @quizz_choice
    @quizz_choice.step = "add_date"
    # @quizz_choice.save!
    redirect_to edit_quizz_choice_path(@quizz_choice)
  end

  def add_actor
    @quizz_choice.actor = params["q"]
    @quizz_choice.step = "add_actor"
    @quizz_choice.save!

    redirect_to movies_path
    # **********
    # LA OU LA MAGIE OPERE
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
