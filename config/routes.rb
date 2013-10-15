Computronix::Application.routes.draw do

  get "/payments/new/:one_click_buy", to: "payments#new", as: 'one_click_buy'
  get "/shop_category/:category_id", to: "front_page#index", as: 'nav'
  get '/setup', to: "setup#index"



  resources :payments do
    collection do
      get 'execute'
      get 'cancel', to: "front_page#index"
      get 'success', to: "front_page#index"
    end
  end
  resources :product

  resources :categories do
    resources :products
  end

  root to: "front_page#index"
end
