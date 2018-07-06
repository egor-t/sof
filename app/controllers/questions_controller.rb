# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Votable
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy like dislike]

  after_action :publish_question, only: [:create]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build

  end

  def edit; end

  def create
    @question = current_user.questions.new(questions_params)
    
    if @question.save
      flash[:notice] = 'Your question was successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(questions_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy if current_user.author_of?(@question)
    redirect_to questions_path
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

  def load_question
    @question = Question.find(params[:id])
    gon.question_id = @question.id
    gon.question_user_id = @question.user_id
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :_destroy])
  end
end
