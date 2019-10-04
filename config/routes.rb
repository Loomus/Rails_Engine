Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :merchants, only: [:index, :show]
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :items, only: [:index, :show]
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :customers, only: [:index, :show]
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :invoices, only: [:index, :show]
      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :invoice_items, only: [:index, :show]
      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :transactions, only: [:index, :show]
    end
  end
end
