Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  
  resources :users, only: [:index, :show]
  resources :users do
    resources :items
    get '/items_search', to: 'items#search'
    resources :menus
    resources :menus do
      get '/dynamic_items', to: 'menus#dynamic_items'
      resources :menu_items, only: :create
      delete '/menu_items', to: 'menu_items#destroy_all'
    end
    resources :week_menus, only: [:index, :create]
    delete '/week_menus', to: 'week_menus#destroy_all'
    resources :menu_records, only: [:create, :update]
    delete '/menu_records', to: 'menu_records#destroy_all'
    resources :item_records, only: [:create, :update]
    delete '/item_records', to: 'item_records#destroy_all'
  end
end
