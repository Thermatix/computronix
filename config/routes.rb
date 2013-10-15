Computronix::Application.routes.draw do

  get "/payments/new/:one_click_buy", to: "payments#new", as: 'one_click_buy'
  get "/shop_category/:category_id", to: "front_page#index", as: 'nav'
  get '/setup', to: "setup#index"

  get '/v1/payments/payment', as: 'payments'

  post '/v1/payments/payment'

  resources :payments
  resources :product

  resources :categories do
    resources :products
  end

  root to: "front_page#index"
end
