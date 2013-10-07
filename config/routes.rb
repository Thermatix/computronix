Computronix::Application.routes.draw do

  get "/shop_category/:category_id", to: "front_page#index", as: 'nav'
  get '/setup', to: "setup#index"

  resources :products
  resources :categories do
    resources :products
  end

  root to: "front_page#index"
end
