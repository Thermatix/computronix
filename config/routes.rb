Computronix::Application.routes.draw do


  get "/payments/new/:payment_id", to: "payments#new", as: 'one_click_buy'
  get "/shop_category/:category_id", to: "front_page#index", as: 'nav'
  get '/setup', to: "setup#index"

  get '/cart', to: 'carts#index', as: 'cart'
  resource :carts, only: [:index,:update,:new] do
    get '/', to: "carts#index"
  end


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
