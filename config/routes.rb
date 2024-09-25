Rails.application.routes.draw do
  namespace :api do
    resources :user_types
    resources :users
  end

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  post :login, to: "sessions#create"
end
