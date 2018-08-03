# frozen_string_literal: true

class AnswersChannel < ApplicationCable::Channel
  def follow(params)
    stream_from "questions/#{params['id']}/answers"
  end
end
