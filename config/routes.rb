Rails.application.routes.draw do
  apipie

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        post 'sign_in', on: :collection
        post 'reconnect', on: :collection
        post 'interested', on: :collection
        resources :products, only: [:index]
        resources :liked_streams, only: [:index]
      end

      resources :follows, only: [:index]
      get 'liked', to: 'likes#index'

      resources :channels, only: [:index, :create, :show, :update, :destroy] do
        resources :streams, only: [:index]
        resources :follows, only: [:create] do
          delete '', on: :collection, action: :destroy
        end
      end

      resources :streams, only: [:index, :create, :show, :update, :destroy] do
        resources :likes, only: [:create] do
          delete '', on: :collection, action: :destroy
        end
        get 'state', to: 'streams#state'
        get 'end_stream', to: 'streams#end_stream'
        get 'rediffusion', to: 'streams#rediffusion'
        resources :chat_messages, only: [:index]
        resources :shared_files, only: [:index]
        resources :commits, only: [:index]
        resources :questions, only: [:index]
        resources :question_votes, only: [:index]
      end

      resources :products, only: [:create, :show, :update, :destroy]

      resources :subscriptions, only: [:create, :update, :destroy]

      resources :shared_files, only: [:create, :update] do
        resources :commits, only: [:create, :update, :destroy, :show]
      end

      post 'mail_webhook', to: 'webhooks#mail_webhook'
      get 'credentials', to: 'shared_files#credentials'
    end
  end
end
