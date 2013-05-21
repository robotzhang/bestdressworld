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
  get '/auth/:provider/callback', :to => 'sessions#create'
  resources :sessions, :only => [:new, :create, :destroy]

  namespace :admin do |admin|
    get 'products/amazon' => 'products#amazon'
    resources :products
    resources :amazon
    match 'categories/create_for_product/:product_id' => 'categories#create_for_product'
    resources :categories
    resources :images
    match 'options/create_for_product/:product_id' => 'options#create_for_product'
    resources :options
  end
end
