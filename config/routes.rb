Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'contacts#new'
  
  resources :users, only: [:index, :show]
  resources :contacts, only: [:new, :create]
  resources :users do
    get '/one_day', to: 'static_pages#one_day'
    get '/calendar', to: 'static_pages#calendar'
    get '/mon_menus', to: 'static_pages#mon_menus'
    get '/tue_menus', to: 'static_pages#tue_menus'
    get '/wed_menus', to: 'static_pages#wed_menus'
    get '/thu_menus', to: 'static_pages#thu_menus'
    get '/fri_menus', to: 'static_pages#fri_menus'
    get '/sat_menus', to: 'static_pages#sat_menus'
    get '/sun_menus', to: 'static_pages#sun_menus'
    resources :items
    get '/items_search', to: 'items#search'
    resources :menus
    resources :menus do
      resources :menu_items, only: [:index, :create]
      get 'menu_items/dynamic_items', to: 'menu_items#dynamic_items'
      delete '/menu_items', to: 'menu_items#destroy_all'
    end
    resources :week_menus, only: [:index, :create]
    delete '/week_menus', to: 'week_menus#destroy_all'
    resources :menu_records, only: [:update]
    delete '/menu_records', to: 'menu_records#destroy_all'
    resources :item_records, only: [:update]
    patch '/item_records', to: 'item_records#update_all'
  end
  
  # サンプル用の一時的なルーティング
  get '/one_day', to: 'sample_pages#one_day'
  get '/calendar', to: 'sample_pages#calendar'
  get '/mon_menus', to: 'sample_pages#mon_menus'
  get '/tue_menus', to: 'sample_pages#tue_menus'
  get '/wed_menus', to: 'sample_pages#wed_menus'
  get '/thu_menus', to: 'sample_pages#thu_menus'
  get '/fri_menus', to: 'sample_pages#fri_menus'
  get '/sat_menus', to: 'sample_pages#sat_menus'
  get '/sun_menus', to: 'sample_pages#sun_menus'
  get '/week_menus', to: 'sample_pages#week_menus'
  get '/menus', to: 'sample_pages#menus'
  get '/new_menu', to: 'sample_pages#new_menu'
  get '/menu', to: 'sample_pages#menu'
  get '/edit_menu', to: 'sample_pages#edit_menu'
  get '/menu_items', to: 'sample_pages#menu_items'
  get 'menu_items/dynamic_items', to: 'sample_pages#dynamic_items'
  get '/items', to: 'sample_pages#items'
  get '/items_search', to: 'sample_pages#search'
  get '/new_item', to: 'sample_pages#new_item'
  get '/item', to: 'sample_pages#item'
  get '/edit_item', to: 'sample_pages#edit_item'
  get '/sample_user', to: 'sample_pages#sample_user'
end
