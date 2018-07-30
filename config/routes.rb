Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :questions do
    resources :comments, module: :questions

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

  resources :answers do
    resources :comments, module: :answers
  end


  resources :attachments, only: [:destroy]

  root 'questions#index'

  mount ActionCable.server => '/cable'


  namespace :api do
    namespace :v1 do
      resources :profiles, only: :index do
        get :me, on: :collection
      end
      
      resources :questions
      resources :answers
    end
  end
end
