Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      get '/items/find', to: 'items#find'
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find_all'
      get '/merchants/find_all', to: 'merchants#find_all'
      
      resources :merchants do
        resources :items, :controller => 'merchant_items'
      end
      resources :items do
        resources :merchant, :controller => 'item_merchant'
      end
    end
  end
end
