Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :companies, except: [ :destroy ]
    resources :ebooks, except: [ :destroy ]
    #  add route for books/id/preview and books/id/full_ebook
    get "ebooks/:id/preview", to: "ebooks#preview"
    post "ebooks/:id/buy", to: "ebooks#buy"
    resources :orders, only: [ :create, :show ]
   end

  scope "/session" do
    get :logged_in, to: "sessions#logged_in"
    delete :logout, to: "sessions#logout"
    post :login, to: "sessions#login"
  end
end
