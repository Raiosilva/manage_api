Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :facilities
      resources :customers

      get '/customers/:search', to: 'customers#show'
    end
  end
end