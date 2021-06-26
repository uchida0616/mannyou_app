Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :tasks do
    collection do
      get :search
      post :confirm
    end
  end
end
