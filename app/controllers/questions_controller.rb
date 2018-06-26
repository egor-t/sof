# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy like dislike]

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

  def like

    @question.like_by(current_user)
  end

  def dislike
    @question.dislike_by(current_user)
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :_destroy])
  end
end
