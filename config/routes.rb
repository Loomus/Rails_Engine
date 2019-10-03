Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      namespace :customers do
        get '/find', to: 'search#show'
      end
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      namespace :invoice_items do
        get '/find', to: 'search#show'
      end 
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
