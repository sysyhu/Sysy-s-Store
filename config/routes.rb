Rails.application.routes.draw do

  namespace :admin do
    get 'product_images/index'
  end

  namespace :admin do
    get 'products/index'
  end

  namespace :admin do
    get 'products/new'
  end

  root 'welcome#index'

  resources :users
  
  resources :sessions

  namespace :admin do
  	root 'sessions#new'
  	resources :sessions
  	resources :categories
  	resources :products do
      resources :product_images, only: [:create, :index, :destroy]
    end
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
