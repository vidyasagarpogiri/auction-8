Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show, :create] do
      resources :bids, only: [:index]
    end
    resources :bids, only: [:update]
    resources :items, only: [:index, :show] do
      resources :bids, only: [:index, :create]
    end
    resource :session, only: [:create, :destroy]

  end

  root to: "static_pages#root"

end
