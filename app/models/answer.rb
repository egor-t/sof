class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true
  validates_length_of :body, minimum: 5
end
