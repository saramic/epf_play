EpfPlay::Application.routes.draw do
  resources :senators, :only => [:index]

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end