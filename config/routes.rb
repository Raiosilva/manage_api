Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :facilities
      resources :customers
    end
  end
end
