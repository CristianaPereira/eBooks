Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :companies, except: [ :destroy ]
    resources :ebooks, except: [ :destroy ]
  end

  scope "/session" do
    get :logged_in, to: "sessions#logged_in"
    delete :logout, to: "sessions#logout"
    post :login, to: "sessions#login"
  end
end
