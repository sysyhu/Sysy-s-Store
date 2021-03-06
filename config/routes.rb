Rails.application.routes.draw do

  root 'welcome#index'

  resources :users
  
  resources :sessions
  delete '/logout' => 'sessions#destroy', as: :logout

  resources :categories, only: [:show]

  resources :products, only: [:show]

  resources :shopping_carts

  resources :addresses do
    member do
      put :set_default_address
    end
  end

  resources :orders

  resources :payments, only: [:index]

  namespace :admin do #!!!一系列配置问题：assets，config...
  	root 'sessions#new'
  	resources :sessions
  	resources :categories
  	resources :products do
      resources :product_images, only: [:create, :index, :destroy, :update]
    end
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
