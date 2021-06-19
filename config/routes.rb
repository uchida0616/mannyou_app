Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    collection do
      get :search
      post :confirm
    end
  end
end
