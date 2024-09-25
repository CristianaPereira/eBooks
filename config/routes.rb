Rails.application.routes.draw do
  namespace :api do
    resources :user_types
    resources :users
  end
end
