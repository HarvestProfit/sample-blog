Rails.application.routes.draw do
  root "pages#home"

  resources :posts, defaults: {format: "json"}
end
