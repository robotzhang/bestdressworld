Bestdressworld::Application.routes.draw do
  root :to => 'application#homepage'
  get 'admin' => 'application#admin'
  get 'products/:seo_url' => 'products#show'
  resources :products
  namespace :admin do |admin|
    get 'products/amazon' => 'products#amazon'
    resources :products
    resources :amazon
    resources :categories
  end
end
