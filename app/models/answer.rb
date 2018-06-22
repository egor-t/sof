# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true

  scope :sorted_by_best_answer, -> { order(best_answer: :desc) }

  def set_all_answers_not_best!
    Answer.update_all(best_answer: false)
  end
end
