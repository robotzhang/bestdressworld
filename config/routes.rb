Bestdressworld::Application.routes.draw do
  root :to => 'application#homepage'
  get 'admin' => 'application#admin'
  namespace :admin do |admin|
    resources :products
  end
end
