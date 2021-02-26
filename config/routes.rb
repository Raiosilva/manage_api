Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :facilities
      resources :customers

      get '/customers/:search', to: 'customers#index'
      get '/contacts/:customer_id', to: 'contacts#index'
    end
  end
end