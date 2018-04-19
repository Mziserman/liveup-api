Rails.application.routes.draw do
  apipie
  mount ActionCable.server => '/cable/:auth_token'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        post 'sign_in', on: :collection
        post 'reconnect', on: :collection
        resources :products, only: [:index]
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

    end
  end
end
