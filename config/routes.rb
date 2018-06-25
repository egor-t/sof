# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers do
      member do
        patch :best_answer
      end
    end
  end

  resources :attachments, only: [:destroy]

  root 'questions#index'
end
