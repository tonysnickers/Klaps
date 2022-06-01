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
  end
end
