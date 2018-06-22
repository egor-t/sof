Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers do
      member do
        patch :best_answer
      end
    end
  end

  root 'questions#index'
end
