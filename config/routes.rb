Rails.application.routes.draw do
  mount Rswag::Ui::Engine => 'api-docs'
  mount Rswag::Api::Engine => 'api-docs'
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :facilities
      resources :customers do
        get 'search', on: :collection

      end

      # get '/customers/:search', to: 'customers#index'
      get '/contacts/:customer_id', to: 'contacts#index'
    end
  end
end