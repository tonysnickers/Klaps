class QuizzChoicesController < ApplicationController
  def new

  end

  def edit
    @quizz_choice = QuizzChoice.find(params[:id])
  end

  def add_casting
    # rajouter les castings choisis à l'instance @quizz_choice
    # @quizz_choice.step = "add_casting"
    # @quizz_choice.save!
    # redirect_to edit_path
  end

  def add_duration
    # rajouter la duration choisis à l'instance @quizz_choice
    # @quizz_choice.step = "add_duration"
    # @quizz_choice.save!
    # redirect_to edit_path
  end

  def add_date
    # rajouter la year choisis à l'instance @quizz_choice
    # @quizz_choice.step = "add_year"
    # @quizz_choice.save!
    # redirect_to affichage des films
  end
end

# @quizz_choice = QuizzChoice.new( ... , step: "initial")
