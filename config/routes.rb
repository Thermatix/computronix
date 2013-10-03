Computronix::Application.routes.draw do

  resources :products

  resources :categories do
    resources :products
  end

  root to: "setup#index"
end
