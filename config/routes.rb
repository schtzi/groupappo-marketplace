Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "/products/search", to: "products#search"

  resources :products do
    resources :bookings, only: [:show]
    resources :product_assignments, only: [:new, :create]
  end
  resources :bookings
  resources :product_assignments, only: [:destroy]

  post 'product_assignments', to: 'product_assignments#create'

  get "/products/search", to: "products#search"
  # get "/products/:id/booking/:id", to: "bookings#show_created", as: "booking_created"

  get '/owner/products', to: 'products#index_owner'
  get '/owner/products/:id', to: 'products#show_owner', as: 'owner_product'
  get '/owner/bookings', to: 'bookings#index_owner'
  get '/products/show/:id', to: 'products#show'
  get '/owner/bookings/:id', to: 'bookings#show_owner', as: 'owner_booking'
  patch '/owner/bookings/:id/confirm', to: 'bookings#confirm', as: 'owner_confirm'
  patch '/owner/bookings/:id/decline', to: 'bookings#decline', as: 'owner_decline'
  patch 'bookings/:id/checkout', to: 'bookings#checkout', as: 'checkout'
end
