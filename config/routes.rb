Rails.application.routes.draw do
  root "pages#home"

  post "/login", to: "users#login"

  resources :posts
  resources :users
end
