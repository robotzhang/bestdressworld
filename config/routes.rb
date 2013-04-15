Bestdressworld::Application.routes.draw do
  root :to => 'application#homepage'
  get 'admin' => 'application#admin'
  resources :products
  namespace :admin do |admin|
    resources :products
    get 'amazon' => 'products#amazon'
  end
end
