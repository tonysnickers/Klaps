class QuizzChoicesController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @quizz_choice = QuizzChoice.new
  end

  def create
    # create le quizz choice
    # insert les différents genres via les params dans la colonne genre
    # quizz_choice.group = Group.find(params[:group_id])
    # quizz_choice.user = current_user
    # if quizz_choice.save
    # else
    # end
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
