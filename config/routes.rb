Rails.application.routes.draw do

  root 'welcome#index'

  resources :users
  
  resources :sessions

  namespace :admin do
  	root 'sessions#new'
  	resources :sessions
  	resources :categories
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
