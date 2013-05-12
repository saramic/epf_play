EpfPlay::Application.routes.draw do
  resources :senators, :only => [:index]
  resources :parties, :only => [:index] do
    collection do
      get :suggest
    end
  end
  match 'parties/(:state)' => 'parties#index', :as => :parties_by

  resources :candidates, :only => [:index]
  match 'candidates/:party/(:state)' => 'candidates#index', :as => :candidates_by

  resources :sources

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end