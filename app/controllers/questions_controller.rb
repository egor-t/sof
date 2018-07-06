# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Votable
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy like dislike]
  before_action :build_answer, only: :show

  after_action :publish_question, only: [:create]

  respond_to :html

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit; end

  def create
    respond_with(@question = current_user.questions.create(questions_params))
  end

  def update
    @question.update(questions_params) if current_user.author_of?(@question)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy) if current_user.author_of?(@question)
  end

  private

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
        'questions',
        ApplicationController.render(
            partial: 'questions/question',
            locals: { question: @question }
        )
    )
  end

  def build_answer
    @answer = @question.answers.build
  end

  def load_question
    @question = Question.find(params[:id])
    gon.question_id = @question.id
    gon.question_user_id = @question.user_id
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :_destroy])
  end
end
