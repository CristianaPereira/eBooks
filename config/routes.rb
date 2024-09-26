Rails.application.routes.draw do
  namespace :api do
    resources :user_types
    resources :users
    resources :companies
    resources :ebooks
  end

  scope "/session" do
    get :logged_in, to: "sessions#logged_in"
    delete :logout, to: "sessions#logout"
    post :login, to: "sessions#login"
  end
end
