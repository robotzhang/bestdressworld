Bestdressworld::Application.routes.draw do
  root :to => 'application#homepage'
  get 'admin' => 'application#admin'
  get 'products/:seo_url' => 'products#show'
  resources :products do
    get 'page/:page', :action => :index, :on => :collection
  end

  match '/signup' => 'users#new'
  match '/login' => 'sessions#new'
  match '/logout' =>  'sessions#destroy'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do |admin|
    get 'products/amazon' => 'products#amazon'
    post 'products/create_category' => 'products#create_category'
    resources :products
    resources :amazon
    resources :categories
    resources :images
  end
end
