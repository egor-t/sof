# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :find_question
  before_action :find_answer, only: %i[update destroy best_answer]

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
  end

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def best_answer
    return unless current_user.author_of?(@question)
    @answer.update(best_answer: true) if @answer.set_all_answers_not_best!
    @answers = @question.answers.sorted_by_best_answer
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
    redirect_to @question
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
