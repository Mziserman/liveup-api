Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # devise_for :user, skip: [:registrations, :sessions, :unlocks, :passwords, :invitations]
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        post 'sign_in', on: :collection
      end

      resources :streams, only: [:index, :create, :show, :update, :destroy]

      resources :products, only: [:show, :index] do
        resources :users, action: :subscribe
      end

      resources :customers, only: [:create]

      post 'webhook', action: :webhook, controller: 'webhooks'

    end
  end
end
