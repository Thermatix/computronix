Computronix::Application.routes.draw do

  get "categories/index"

  resources :categories

  root to: "categories#index"
end
