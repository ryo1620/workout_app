Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  
  resources :users, only: [:index, :show]
  resources :users do
    resources :menus
    resources :week_menus, only: [:create, :destroy]
  end
end
