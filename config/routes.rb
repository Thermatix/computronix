Computronix::Application.routes.draw do

  get "cart/index"
  get "cart/add"
  get "cart/update"
  get "cart/delete"
  get "sales/cancel"
  get "sales/success"
  get "/payments/new/:payment_id", to: "payments#new", as: 'one_click_buy'
  get "/shop_category/:category_id", to: "front_page#index", as: 'nav'
  get '/setup', to: "setup#index"
  post '/cart', to: "front_page#index", as: 'cart'

  resources :payments do
    collection do
      get 'execute'
      get 'cancel'
      post 'new', as: 'new'
    end
  end
  resources :sales do
    collection do
      get 'cancel'
      get 'success'
    end
  end

  resources :product

  resources :categories do
    resources :products
  end

  root to: "front_page#index"
end
