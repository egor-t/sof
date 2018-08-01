class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_question, only: :create
  before_action :set_subscription, only: :destroy

  skip_authorization_check

  respond_to :html

  def create
    @subscription = @question.subscriptions.create(user: current_user)
    redirect_to @question, notice: 'Now you are subscribe to that question.'
  end

  def destroy
    @subscription.destroy
    redirect_to @subscription.question, notice: 'Now you are unsubscribe from that question.'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
