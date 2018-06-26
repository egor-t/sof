# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    member do
      put 'like', to: 'questions#like'
      put 'dislike', to: 'questions#dislike'
    end

    resources :answers do
      member do
        patch :best_answer
        put 'like', to: 'answers#like'
        put 'dislike', to: 'answers#dislike'
      end
    end
  end

  resources :attachments, only: [:destroy]

  root 'questions#index'
end
