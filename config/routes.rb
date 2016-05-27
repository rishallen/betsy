Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'
  resources :users, :only => [:new, :create] do
    resources :orders, except: [:edit]
    resources :reviews, :only => [:new, :create]
    resources :products, except: [:destroy]
  end
  resources :reviews
  resources :products, except: [:new, :create, :update, :edit, :destroy] do
    resources :reviews, :only => [:new, :create]
    collection do
      get 'by_category/:category' => 'products#index', as: 'by_category'
      get 'by_category/' => 'products#index'
      get 'by_seller/:user_id' => 'products#index'
      get 'by_sellers/' => 'products#index'
    end
  end

  get '/cart' => 'orders#cart'

  get '/cart/checkout' => 'orders#checkout'
  patch '/cart/checkout' => 'orders#order_placed' #does patch need to point to checkout page? Or to the destination?
  get '/cart/checkout/review_order/:id' => 'orders#review'
  post '/cart' => 'orders#get_rates', as: :get_rates

  resources :sessions, :only => [:new, :create]
  delete "/logout" => "sessions#destroy"

  post '/add_to_cart/:product_id' => 'orders#add_to_cart', :as => 'add_to_cart'
  post '/cart' => 'order_items#update'
  delete '/cart/order_items/:id' => 'order_items#destroy', :as => 'delete_order_item'
  get 'orders/:id' => 'orders#show', :as => 'order'

end
