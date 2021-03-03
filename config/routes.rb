Rails.application.routes.draw do

  get 'products/show'

  get 'categories/show'

  root 'welcome#index'

  resources :users
  
  resources :sessions

  resources :categories, only: [:show]

  resources :products, only: [:show]

  namespace :admin do
  	root 'sessions#new'
  	resources :sessions
  	resources :categories
  	resources :products do
      resources :product_images, only: [:create, :index, :destroy, :update]
    end
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
