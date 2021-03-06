# frozen_string_literal: true

class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :set_question, only: :show

  skip_authorization_check

  def index
    @questions = Question.all
    respond_with @questions
  end

  def create
    respond_with(@question = current_resource_owner.questions.create(question_params))
  end

  def show
    respond_with @question
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
