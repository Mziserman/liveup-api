Rails.application.routes.draw do
  apipie
  mount ActionCable.server => '/cable/:auth_token'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        post 'sign_in', on: :collection
        post 'reconnect', on: :collection
        post 'interested', on: :collection
        resources :products, only: [:show]
        resources :liked_streams, only: [:index]
      end

      resources :follows, only: [:index]
      get 'liked', to: 'likes#index'

      resources :channels, only: [:index, :create, :show, :update, :destroy] do
        resources :follows, only: [:create] do
          delete '', on: :collection, action: :destroy
        end
      end

      resources :streams, only: [:index, :create, :show, :update, :destroy] do
        resources :likes, only: [:create] do
          delete '', on: :collection, action: :destroy
        end
        post 'buy', action: :buy
        resources :chat_messages, only: [:index]
        resources :shared_files, only: [:index]
        resources :commits, only: [:index]
        resources :questions, only: [:index]
        resources :question_votes, only: [:index]
      end

      resources :products, only: [:show, :index] do
        post 'buy', action: :buy
      end

      resources :customers, only: [:create]

      post 'webhook', action: :webhook, controller: 'webhooks'

      resources :subscriptions, only: [:create, :update, :destroy]

      resources :shared_files, only: [:create, :update] do
        resources :commits, only: [:create, :update, :destroy, :show]
      end

    end
  end
end
